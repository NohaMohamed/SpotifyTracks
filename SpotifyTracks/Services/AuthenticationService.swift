//
//  AuthenticationService.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 22/08/2022.
//

import Foundation
import NetworkingLayer

protocol AuthenticationServiceProtocol {
    var apiClient: APICleintProtocol { get set }
    func reuqestToken(code: String, compeletion: @escaping (Result<AuthenticationModel, CustomNetworkError>) -> Void)
    func refreshToken(refreshToken: String, compeletion: @escaping (Result<AuthenticationModel, CustomNetworkError>) -> Void)
    func cacheToken(_ tokenModel : AuthenticationModel)
}
struct AuthenticationService: AuthenticationServiceProtocol {
    
    var apiClient: APICleintProtocol = APICleint.shared
    var authenticationManager = AuthenticationManager()
}
// MARK: - Extensions

extension AuthenticationService {
    
    // MARK: - Functions
    func reuqestToken(code: String, compeletion: @escaping (Result<AuthenticationModel, CustomNetworkError>) -> Void) {
        apiClient.send(request:  AuthenticationRequest.getAccessToken(code: code), compeletion: compeletion)
    }
    func refreshToken(refreshToken: String,compeletion: @escaping (Result<AuthenticationModel, CustomNetworkError>) -> Void) {
        apiClient.send(request: AuthenticationRequest.refreshToken(refreshToken), compeletion: compeletion)
    }
    func cacheToken(_ tokenModel: AuthenticationModel) {
        authenticationManager.cacheAccessToken(tokenModel)
    }
}

