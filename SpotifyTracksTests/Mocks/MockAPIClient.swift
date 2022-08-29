//
//  MockAPIClient.swift
//  SpotifyTracksTests
//
//  Created by Noha Mohamed on 21/08/2022.
//

import Foundation
import NetworkingLayer
@testable import SpotifyTracks

protocol MockAPIClientProtocol : APICleintProtocol {
    var data: Data? {get set}
    var error: CustomNetworkError? {get set}
}
class MockAPIClient: MockAPIClientProtocol {
    var data: Data?
    
    var error: CustomNetworkError?
    
    func configure(data: Data?, error: CustomNetworkError?){
        self.data = data
        self.error = error
    }
    
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType: Codable {
        if let data = data  {
            do{
                let decodedData = try JSONDecoder().decode(ResponsType.self, from: data)
                compeletion(.success(decodedData))
            }catch {
                compeletion(.failure(.canNotDecodeObject))
            }
        }else if let error = error {
            compeletion(.failure(error))
        }else{
            compeletion(.failure(.generic))
        }
    }
}
