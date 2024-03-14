//
//  AddFavoriteGameRepository.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Combine
import Shared

public struct AddGameRepository<
    FavoriteLocalDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
  FavoriteLocalDataSource.Request == GameEntity,
  FavoriteLocalDataSource.Response == GameEntity,
  Transformer.Entity == GameEntity,
  Transformer.Domain == GameModel
{
    public typealias Request = GameModel
    public typealias Response = Bool

    private let localDataSource: FavoriteLocalDataSource
    private let mapper: Transformer

    public init(
        localDataSource: FavoriteLocalDataSource,
        mapper: Transformer) {
            self.localDataSource = localDataSource
            self.mapper = mapper
        }

    public func execute(request: GameModel?) -> AnyPublisher<Bool, Error> {
        guard let gameModel = request else {
            return Future<Bool, Error> { completion in
                completion(.failure(DatabaseError.requestFailed))
            }.eraseToAnyPublisher()
        }

        return localDataSource.add(entities: mapper.transformDomainToEntity(domain: gameModel))
            .eraseToAnyPublisher()
    }
}
