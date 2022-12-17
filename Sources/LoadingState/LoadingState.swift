//
//  LoadingState.swift
//
//  Created by Sean Langhi on 9/22/22.
//

import Foundation

// MARK: - Enum cases

public enum LoadingState<Value, Error> {
    case notStarted,
         loading,
         success(Value),
         failure(Error)
}

// MARK: - APIs

public extension LoadingState {

    var isNotStarted: Bool {
        switch self {
        case .notStarted:
            return true
        default:
            return false
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    var isFailure: Bool {
        switch self {
        case .failure:
            return true
        default:
            return false
        }
    }

    var maybeValue: Value? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }

    var maybeError: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    func mapValue<NewValue>(
        _ transform: (Value) -> NewValue
    ) -> LoadingState<NewValue, Error> {
        switch self {
        case .notStarted:
            return .notStarted
        case .loading:
            return .loading
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }

    func mapError<NewError>(
        _ transform: (Error) -> NewError
    ) -> LoadingState<Value, NewError> {
        switch self {
        case .notStarted:
            return .notStarted
        case .loading:
            return .loading
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .failure(transform(error))
        }
    }

    var ignoringValue: LoadingState<Void, Error> {
        mapValue { _ in () }
    }

    var ignoringError: LoadingState<Value, Void> {
        mapError { _ in () }
    }
}

// MARK: - `Equatable` conformance (almost)

/// NOTE: Due to Swift language restrictions, this package cannot declare `LoadingState`'s conditional adoption of the `Equatable` protocol in this location in a way that will transfer the effect to your client code.  Although this package can provide the `==` operator to your client, you must copy-paste the following line of code to your client in order to register the conditional protocol adoption:
/// `extension LoadingState: Equatable where Value: Equatable, Error: Equatable {}`
public extension LoadingState
where Value: Equatable, Error: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.notStarted, .notStarted),
             (.loading, .loading):
            return true
        case let (.success(lhsValue), .success(rhsValue)):
            return lhsValue == rhsValue
        case let (.failure(lhsError), .failure(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
