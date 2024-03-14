//
//  GetGamesRepository.swift
//
//
//  Created by Galah Seno on 12/03/24.
//

import Core
import Combine
import Shared

public struct HomeGamesRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
  RemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Domain == [GameModel]
{

    public typealias Request = Any
    public typealias Response = [GameModel]

    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            self.remoteDataSource = remoteDataSource
            self.mapper = mapper
        }

    public func execute(request: Any?) -> AnyPublisher<[GameModel], Error> {
        return remoteDataSource.execute(request: nil)
            .map { mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
}
