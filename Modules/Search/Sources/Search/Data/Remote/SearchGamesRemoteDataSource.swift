//
//  SearchGameRemoteDataSource.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Shared
import Combine
import Alamofire

public struct SearchGamesRemoteDataSource : DataSource {

    public typealias Request = String

    public typealias Response = [GameResponse]

    private let _endpoint: String

    public init(endpoint: String) {
        _endpoint = endpoint
    }

    public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in

            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }

            if let url = URL(string: _endpoint + request) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.games))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
