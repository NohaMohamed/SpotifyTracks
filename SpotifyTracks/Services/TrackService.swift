//
//  TrackService.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 29/08/2022.
//

import Foundation
import NetworkingLayer

protocol TrackServiceProtocol {
    var apiClient: APIClientManager { get set }
    func getTrackDetails(id: String,compeletion : @escaping (Result<SearchResult.Track.Item, CustomNetworkError>) -> Void)
}
struct TrackService{
    
    // MARK: - Dependencies
    
    var apiClient: APIClientManager = APIClientManager()

}
// MARK: - Extensions

extension TrackService: TrackServiceProtocol {
    
    // MARK: - Functions
    func getTrackDetails(id: String,compeletion : @escaping (Result<SearchResult.Track.Item, CustomNetworkError>) -> Void){
        apiClient.request(request: SpotifyTracksRequest.getTrack(id: id), cacheRequest: false, compeletion: compeletion)
    }
}
