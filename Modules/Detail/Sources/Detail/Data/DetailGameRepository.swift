//
//  GetGameRepository.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Combine

public struct DetailGameRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
  RemoteDataSource.Request == Any,
  RemoteDataSource.Response == GameDetailResponse,
  Transformer.Response == GameDetailResponse,
  Transformer.Domain == GameDetail
{

    public typealias Request = String
    public typealias Response = GameDetail

    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer

    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            self.remoteDataSource = remoteDataSource
            self.mapper = mapper
        }

    public func execute(request: String?) -> AnyPublisher<GameDetail, Error> {
        return remoteDataSource.execute(request: nil)
            .map { mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
}
