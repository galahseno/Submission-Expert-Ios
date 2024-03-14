//
//  SearchGameRepository.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Core
import Combine
import Shared

public struct SearchGamesRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
  RemoteDataSource.Request == String,
  RemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Domain == [GameModel]
{

    public typealias Request = String
    public typealias Response = [GameModel]

    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            self.remoteDataSource = remoteDataSource
            self.mapper = mapper
        }

    public func execute(request: String?) -> AnyPublisher<[GameModel], Error> {
        guard let request = request else { fatalError("Request cannot be empty") }

        return remoteDataSource.execute(request: request)
            .map { mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
}
