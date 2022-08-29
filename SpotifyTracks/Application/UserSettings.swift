//
//  UserDefaults.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 22/08/2022.
//

import Foundation

protocol UserSettingsProtocol {
    func cacheToken(authTokenModel: AuthenticationModel)
    func getToken() -> UserAuthentication?
}

struct UserSettings: UserSettingsProtocol {
    private let userDefaults = UserDefaults.standard
    
    enum Keys: String, CodingKey {
        case accessToken, refreshToken, expirationDate
    }
    
    func cacheToken( authTokenModel: AuthenticationModel) {
        userDefaults.set(authTokenModel.accessToken, forKey: Keys.accessToken.rawValue)
        if let refreshToken = authTokenModel.refreshToken {
            userDefaults.set(refreshToken, forKey: Keys.refreshToken.rawValue)}
        userDefaults.set(Date().addingTimeInterval(TimeInterval(authTokenModel.expiresIn)), forKey: Keys.expirationDate.rawValue)
    }
    
    func getToken() -> UserAuthentication? {
        guard let accessToken = userDefaults.string(forKey: Keys.accessToken.rawValue),let refreshToken = userDefaults.string(forKey: Keys.refreshToken.rawValue) ,let expirationDate = userDefaults.object(forKey: Keys.expirationDate.rawValue) as? Date
        else { return nil }
        
        return UserAuthentication(accessToken: accessToken, expiresDate: expirationDate, refreshToken: refreshToken)
    }
}
