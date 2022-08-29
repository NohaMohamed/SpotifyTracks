//
//  SearchResponseMock.swift
//  SpotifyTracksTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
@testable import SpotifyTracks

class SearchResponseMock {
    static func getSearchResponse() -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: "success_response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    static func getWrongResponse() -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: "wrong_response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    static func getTrack() -> SearchResult.Track.Item{
        return   SearchResult.Track.Item(album: nil, artists: nil, availableMarkets: nil, discNumber: nil, durationMs: nil, explicit: nil, externalIds: nil, externalUrls: nil, href: nil, id: nil, isLocal: nil, name: "Adele", popularity: 20, previewUrl: nil, trackNumber: nil, type: nil, uri: nil)
    }
    static func getTrackUIModel() -> TrackUIModel{
        return  TrackUIModel(trackName: "Easy On Me", artistName: "Adele", popularity: 12,imageUrl: "")
    }
}

