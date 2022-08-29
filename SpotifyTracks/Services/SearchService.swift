//
//  SearchService.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation
import NetworkingLayer

protocol SearchServiceProtocol {
    var apiClient: APIClientManager { get set }
    func fetchSearchResult(query: String,compeletion : @escaping (Result<SearchResult, CustomNetworkError>) -> Void)
    func loadNextPage(url: String ,compeletion : @escaping (Result<SearchResult, CustomNetworkError>) -> Void)
}
struct SearchService{
    
    // MARK: - Dependencies
    
    var apiClient: APIClientManager = APIClientManager()

}
// MARK: - Extensions

extension SearchService: SearchServiceProtocol {
    
    // MARK: - Functions
    func fetchSearchResult(query: String, compeletion: @escaping (Result<SearchResult, CustomNetworkError>) -> Void) {
        apiClient.request(request: SpotifyTracksRequest.search(query: query), cacheRequest: true, compeletion: compeletion)
    }
    func loadNextPage(url: String, compeletion: @escaping (Result<SearchResult, CustomNetworkError>) -> Void) {
        apiClient.request(request: SpotifyTracksRequest.loadNextPage(url: url), cacheRequest: true, compeletion: compeletion)
    }
}
