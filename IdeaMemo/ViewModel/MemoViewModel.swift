//
//  MemoViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/03.
//

import Foundation
import Combine
import CloudKit

final class MemoViewModel: ObservableObject, Identifiable {
    // Input
    @Published var title: String = ""
    @Published var content: String = ""
    
    // Output
    @Published var error: Error?

    var cached: CurrentValueSubject<Memo?, Never>
    var commitEvent = PassthroughSubject<Void, Never>()
    var disappearEvent = PassthroughSubject<Void, Never>()
    
    private var cancellables: [AnyCancellable] = []
    
    init(memo: Memo?) {
        cached = CurrentValueSubject<Memo?, Never>(memo)
        
        Publishers
            .CombineLatest(
                $title.removeDuplicates(),
                $content.removeDuplicates()
            )
            .receive(on: RunLoop.main)
            .sink { [weak self] title, content in
                guard let self = self else { return }
                self.title = title
                self.content = content
                guard let memo = memo else { return }
                self.cached.value = Memo(id: memo.id, title: title, content: content)
            }
            .store(in: &self.cancellables)

        Publishers
            .Zip(
                commitEvent,
                disappearEvent
            )
            .combineLatest(cached)
            .map { $1 }
            .filterNil()
            .flatMap { memo -> AnyPublisher<Memo, Error> in
                return CloudMemoRecord.update(memo: memo)
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                ApplicationStore.shared.dispatch(MemoState.Action.error(error))
            }, receiveValue: { memo in
                ApplicationStore.shared.dispatch(MemoState.Action.update(memo))
                // TODO: キャッシュされたメモの中身が空白の場合はメモを削除するようにする
            })
            .store(in: &self.cancellables)
        
        ApplicationStore.shared.memoState.map { $0.error }
            .sink { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.error = nil
                    return
                }
                self.error = error
            }
            .store(in: &self.cancellables)
    }
    
    private(set) lazy var onAppear: () -> Void = { [unowned self] in
        Just(self.cached.value)
            .filter { $0 == nil }
            .sink { [unowned self] memo in
                // 新規作成されたメモの場合は、一旦 iCloud 上にデータを保存する
                CloudMemoRecord.create(title: "", content: "") { result in
                    switch result {
                    case .success(let memo):
                        self.cached.value = memo
                    case .failure(let error):
                        ApplicationStore.shared.dispatch(MemoState.Action.error(error))
                    }
                }
            }
            .store(in: &self.cancellables)
    }
}
