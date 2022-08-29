//
//  APICLientManager.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 26/08/2022.
//

import Foundation
import NetworkingLayer

protocol APIManagerProtocol {
   func request<ResponsType>(request: RequestProtocol,cacheRequest: Bool  ,compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType: Codable
}
class APIClientManager : APIManagerProtocol {
    
    lazy var authentication = AuthenticationManager()
    var apiClient = APICleint.shared
    let urlCache = URLCache.shared
    
    func request<ResponsType>(request: RequestProtocol,cacheRequest: Bool ,compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType: Codable{
        if authentication.shouldRefresh {
            guard let refreshToken = authentication.refreshToken else {
               return
           }
            requestRefreshToken(refreshToken:refreshToken, completion: { result in
                switch result {
                case .success(let refreshTokenModel):
                    self.authentication.cacheRefreshToken(refreshTokenModel)
                    self.apiClient.send(request: request, compeletion: compeletion)
                case .failure(_):
                    break
                }
            })
        }else{
            apiClient.send(request: request, compeletion: compeletion)
        }
    }
    func requestRefreshToken(refreshToken : String , completion: @escaping (Result<RefreshTokenModel,CustomNetworkError>) -> Void) {
        apiClient.send(request: AuthenticationRequest.refreshToken(refreshToken), compeletion:completion)
    }
}
