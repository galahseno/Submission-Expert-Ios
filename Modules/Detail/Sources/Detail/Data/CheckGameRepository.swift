//
//  CheckFavoriteGameRepository.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Combine
import Shared

public struct CheckGameRepository<
    FavoriteLocalDataSource: LocaleDataSource
>: Repository where
  FavoriteLocalDataSource.Request == GameEntity,
  FavoriteLocalDataSource.Response == GameEntity
{

    public typealias Request = String
    public typealias Response = Bool

    private let localDataSource: FavoriteLocalDataSource

    public init(
        localDataSource: FavoriteLocalDataSource) {
            self.localDataSource = localDataSource
        }

    public func execute(request: String?) -> AnyPublisher<Bool, Error> {
        return localDataSource.check(request: request)
            .eraseToAnyPublisher()
    }
}
