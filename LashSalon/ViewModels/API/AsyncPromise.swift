//
//  AsyncPromise.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 19.08.22.
//

// Этот файл нужен для отработки выхода из apple sign
import Combine

public struct AsyncPromise<T> {
    @MainActor
    @discardableResult
    public static func fulfiil(_ promise: Future<T, Error>, storedIn cancellables: inout Set<AnyCancellable>) async throws -> T {
        try await withCheckedContinuation({ continuation in
            promise.sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let err):
                    continuation.resume(throwing: err as! Never)
                }
            } receiveValue: { value in
                continuation.resume(returning: value)
            }
            .store(in: &cancellables)
        })
    }
}
