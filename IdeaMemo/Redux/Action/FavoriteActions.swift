//
//  FavoriteActions.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/22.
//Copyright © 2020 mycity. All rights reserved.
//

import RxSwift
import ReSwift

// Actions
extension FavoriteState {
    public enum Action: ReSwift.Action {
        case requestStart
        case requestError(Error)
        case systemError(Error)
    }
}

// Action Dispatcher
public struct FavoriteActionDispatcher {

    public static func getFavoriteRequest(disposeBag: DisposeBag) {
        ApplicationStore.shared.dispatch(FavoriteState.Action.requestStart)
//        FavoriteAPI.get()
//            .subscribe(
//                onSuccess: { watchedUsers in
//                    ApplicationStore.shared.dispatch(FavoriteState.Action.get(watchedUsers: watchedUsers))
//                },
//                onError: { error in
//                    ApplicationStore.shared.dispatch(FavoriteState.Action.requestError(error))
//                }
//            )
//            .disposed(by: disposeBag)
    }
    
    public static func postFavoriteRequest(userId: Int, disposeBag: DisposeBag) {
        ApplicationStore.shared.dispatch(FavoriteState.Action.requestStart)
//        FavoriteAPI.post(userId: userId)
//            .subscribe(
//                onSuccess: { watchedUser in
//                    ApplicationStore.shared.dispatch(FavoriteState.Action.add(watchedUser: watchedUser))
//                },
//                onError: { error in
//                    ApplicationStore.shared.dispatch(FavoriteState.Action.requestError(error))
//                }
//            )
//            .disposed(by: disposeBag)
    }
    
    public static func deleteFavoriteRequest(watchedUserId: Int, disposeBag: DisposeBag) {
        ApplicationStore.shared.dispatch(FavoriteState.Action.requestStart)
//        FavoriteAPI.delete(watchedUserId: watchedUserId)
//            .subscribe(
//                onSuccess: { watchedUser in
//                    ApplicationStore.shared.dispatch(FavoriteState.Action.remove(watchedUser: watchedUser))
//                },
//                onError: { error in
//                    ApplicationStore.shared.dispatch(FavoriteState.Action.requestError(error))
//                }
//            )
//            .disposed(by: disposeBag)
    }
}
