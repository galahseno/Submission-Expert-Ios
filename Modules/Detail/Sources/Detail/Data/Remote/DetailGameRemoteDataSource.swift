//
//  GetGameRemoteDataSource.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Combine
import Alamofire

public struct DetailGameRemoteDataSource : DataSource {

    public typealias Request = Any

    public typealias Response = GameDetailResponse

    private let _endpoint: String

    public init(endpoint: String) {
        _endpoint = endpoint
    }

    public func execute(request: Any?) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse, Error> { completion in

            if let url = URL(string: _endpoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
