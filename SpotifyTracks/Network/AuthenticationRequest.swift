//
//  AuthenticationService.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 18/08/2022.
//

import Foundation
import NetworkingLayer

struct AuthenticationConstant{
    static let clientID = "92895b862a2340cc85e690626caf99dd"
    static let redirectURL = "spotifytracks://returnAfterLogin"
    static let scope = "user-read-private"
    static let clientSecret = "b3c76142d65948589aed6167d69f3f62"
}

enum AuthenticationRequest: RequestProtocol {
    case login
    case getAccessToken(code: String)
    case refreshToken(_ refreshToken: String)
    var endPoint: String {
        switch self{
        case .login: return "authorize"
        case .getAccessToken, .refreshToken: return "api/token"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAccessToken,.refreshToken:
            let authorization = AuthenticationConstant.clientID + ":" + AuthenticationConstant.clientSecret
            let authorizationData = authorization.data(using: .utf8)
            let authorizationString = "Basic " + (authorizationData?.base64EncodedString() ?? "")
            return [
                Keys.contentType.rawValue :  "application/x-www-form-urlencoded",
                Keys.authorization.rawValue : authorizationString
            ]
        default: return nil
        }
    }
    var baseURL: String{
        return "https://accounts.spotify.com/"
    }
    
    var parameters: Parameters? {
        switch self{
        case .login:
            return[
                Keys.clientId.rawValue : AuthenticationConstant.clientID,
                Keys.redirectURL.rawValue : AuthenticationConstant.redirectURL,
                Keys.scope.rawValue : AuthenticationConstant.scope ,
                Keys.responseType.rawValue : "code",
            ]
        case .getAccessToken(let code):
            return [
                Keys.redirectURL.rawValue : AuthenticationConstant.redirectURL,
                Keys.grantType.rawValue : "authorization_code",
                Keys.code.rawValue : code
            ]
        case .refreshToken(let refreshToken):
            return [
                Keys.redirectURL.rawValue : AuthenticationConstant.redirectURL,
                Keys.grantType.rawValue : "refresh_token",
                Keys.refreshToken .rawValue : refreshToken
            ]
        }
    }
    enum Keys: String, CodingKey {
        case clientId = "client_id"
        case redirectURL = "redirect_uri"
        case scope = "scope"
        case responseType = "response_type"
        case contentType = "Content-Type"
        case grantType = "grant_type"
        case authorization = "Authorization"
        case code = "code"
        case refreshToken = "refresh_token"
         
    }
}
extension AuthenticationRequest{
    func convertRequestIntoURL() -> URL? {
        let url = self.baseURL + self.endPoint 
        var bodyComponents = URLComponents(string: url)
        let queryItems = parameters?.map {
            URLQueryItem(name: $0, value: $1)
        }
        bodyComponents?.queryItems = queryItems
        return bodyComponents?.url
    }
}
