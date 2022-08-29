//
//  SearchServiceMock.swift
//  SpotifyTracksTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
import NetworkingLayer
@testable import SpotifyTracks

class SearchServiceMock: SearchServiceProtocol {
    var apiClient: APIClientManager = APIClientManager()
    
    var apiClientt: APICleintProtocol = MockAPIClient()
    private lazy var mockAPI = apiClientt as? MockAPIClient
    
    func configure(data: Data?, error: CustomNetworkError?){
        mockAPI?.configure(data: data, error: error)
    }
    func fetchSearchResult(query: String,compeletion : @escaping (Result<SearchResult, CustomNetworkError>) -> Void){
        mockAPI?.send(request: SpotifyTracksRequest.search(query: query), compeletion: compeletion)
        
    }
    func loadNextPage(url: String ,compeletion : @escaping (Result<SearchResult, CustomNetworkError>) -> Void){
        
    }
}
