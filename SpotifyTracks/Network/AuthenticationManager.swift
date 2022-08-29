//
//  AuthenticationManager.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 26/08/2022.
//

import Foundation
protocol AuthenticationMangerProtocol {
    func requestToken(code: String)
}
struct AuthenticationManager {
    
    private var userSettting = UserSettings()
     init() {}
    
    var isSignIn: Bool {
        return acccessToken != nil
    }
    var acccessToken  : String?{
        return userSettting.getToken()?.accessToken
    }
    var refreshToken : String?{
        return userSettting.getToken()?.refreshToken
    }
    var tokenExpiredDate : Date?{
        return userSettting.getToken()?.expiresDate
    }
    var shouldRefresh : Bool {
        guard let tokenExpiredDate = tokenExpiredDate else {
            return false
        }
        let currentDate = Date()
        
        return currentDate >= tokenExpiredDate
    }
    func cacheRefreshToken(_ refreshTokenModel: RefreshTokenModel){
        userSettting.cacheToken(authTokenModel: AuthenticationModel(accessToken: refreshTokenModel.accessToken, expiresIn: refreshTokenModel.expiresIn, refreshToken: nil, scope: nil, tokenType: refreshTokenModel.tokenType))
    }
    func cacheAccessToken(_ tokenModel: AuthenticationModel){
        userSettting.cacheToken(authTokenModel: tokenModel)
    }
    
}

