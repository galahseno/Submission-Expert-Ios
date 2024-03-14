//
//  FavoriteGameRepository.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Combine
import Core
import Shared

public struct FavoriteGameRepository<
    FavoriteLocalDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
  FavoriteLocalDataSource.Response == GameEntity,
  Transformer.Entity == [GameEntity],
  Transformer.Domain == [GameModel]
{

    public typealias Request = Any
    public typealias Response = [GameModel]

    private let localDataSource: FavoriteLocalDataSource
    private let mapper: Transformer

    public init(
        localDataSource: FavoriteLocalDataSource,
        mapper: Transformer) {
            self.localDataSource = localDataSource
            self.mapper = mapper
        }

    public func execute(request: Any?) -> AnyPublisher<[GameModel], Error> {
        return localDataSource.list()
            .map { mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
