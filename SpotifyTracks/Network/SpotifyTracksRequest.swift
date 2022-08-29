//
//  SpotifyRequest.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 3/28/21.
//

import Foundation
import NetworkingLayer

enum SpotifyTracksRequest: RequestProtocol {
    case search(query: String)
    case getTrack(id: String)
    case loadNextPage(url: String)
    
    var endPoint: String {
        switch self{
        case .search: return "search"
        case .getTrack: return "tracks"
        default: return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return [Keys.contentType.rawValue :  "application/json",Keys.authorization.rawValue :"Bearer \(UserSettings().getToken()!.accessToken)"]
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let query):
            return [
                Keys.type.rawValue : "track",
                Keys.limit.rawValue : "10",
                Keys.query.rawValue : query,
            ]
        case .getTrack(let id):
                return [
                    Keys.id.rawValue : id
                ]
        default:
            break
        }
        return nil
    }
    var baseURL: String {
        switch self {
        case .loadNextPage(let url):
            return url
        default: return "https://api.spotify.com/v1/"
        }
    }
    var cacheRequest: Bool?{
        return true
    }
    enum Keys: String, CodingKey {
        case limit = "limit"
        case type = "type"
        case query = "q"
        case contentType = "Content-Type"
        case authorization = "Authorization"
        case id = "id"
    }
}

extension RequestProtocol {
    var baseURL: String {
        return "https://api.spotify.com/v1/"
    }
    var cacheRequest: Bool? {
        return false
    }
    
}
