//
//  SearchPresenterMock.swift
//  SpotifyTracksTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
@testable import SpotifyTracks
class SearchPresenterMock: SearchPresenterToViewProtocol{
    

    var isLoadingNextPage: Bool = false
    
  
    var loadingNextPage: Bool = false
    var isloading: Bool = false
    var isSearchCalled = false
    var pageCount = 0
    
    func loadNextPage() {
        loadingNextPage = true
    }
    
    func getTracks() -> [TrackUIModel] {
        return [SearchResponseMock.getTrackUIModel()]
    }
    func resetTracks() {
        pageCount = 1
    }
    func search(_ text: String) {
        isSearchCalled = true
        return
    }
    
    func getTrackDetails(at row: Int) -> SearchResult.Track.Item? {
        return SearchResponseMock.getTrack()
    }
    
}
