//
//  Combine+Optional.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import Combine

public protocol OptionalType {
    associatedtype Wrapped

    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { self }
}

extension Publisher where Output: OptionalType {
    public func filterNil() -> AnyPublisher<Output.Wrapped, Failure> {
        flatMap { output -> AnyPublisher<Output.Wrapped, Failure> in
            guard let output = output.optional else {
                return Empty<Output.Wrapped, Failure>(completeImmediately: false)
                    .eraseToAnyPublisher()
            }
            return Just(output)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
