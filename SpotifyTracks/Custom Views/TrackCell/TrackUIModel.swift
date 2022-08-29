//
//  TrackUIModel.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
class TrackUIModel : NSObject {
    
    var trackName: String? = nil
    var artistName: String? = nil
    var popularity: Int? = nil
    var imageUrl: String? = nil
    init(trackName: String?, artistName : String? , popularity: Int?, imageUrl: String?) {
        self.trackName = trackName
        self.artistName = artistName
        self.popularity = popularity
        self.imageUrl = imageUrl
    }
}
