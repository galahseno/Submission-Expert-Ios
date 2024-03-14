//
//  ApiCall.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 04/03/24.
//

import Foundation

struct API {

    static let apiKey = Bundle.main.infoDictionary?["ApiKey"] as? String
    static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {

    var url: String { get }

}

enum Endpoints {

    enum Gets: Endpoint {
        case games
        case detail(id: String)
        case search

        public var url: String {
            switch self {
            case .games: return "\(API.baseUrl)games?key=\(API.apiKey ?? "")"
            case .detail(let id): return "\(API.baseUrl)games/\(id)?key=\(API.apiKey ?? "")"
            case .search: return "\(API.baseUrl)games?key=\(API.apiKey ?? "")&search="
            }
        }
    }

}
