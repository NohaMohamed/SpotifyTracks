//
//  SearchResult.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 19/08/2022.
//
import Foundation

struct SearchResult : Codable {

	let tracks : Track?


	enum CodingKeys: String, CodingKey {
		case tracks
	}
   
    struct Track : Codable {

        let href : String?
        let items : [Item]?
        let limit : Int?
        let next : String?
        let offset : Int?
        let previous : String?
        let total : Int?


        enum CodingKeys: String, CodingKey {
            case href = "href"
            case items = "items"
            case limit = "limit"
            case next = "next"
            case offset = "offset"
            case previous = "previous"
            case total = "total"
        }
        struct Item : Codable {
            
            let album : Album?
            let artists : [Artist]?
            let availableMarkets : [String]?
            let discNumber : Int?
            let durationMs : Int?
            let explicit : Bool?
            let externalIds : ExternalId?
            let externalUrls : ExternalUrl?
            let href : String?
            let id : String?
            let isLocal : Bool?
            let name : String?
            let popularity : Int?
            let previewUrl : String?
            let trackNumber : Int?
            let type : String?
            let uri : String?


            enum CodingKeys: String, CodingKey {
                case album
                case artists = "artists"
                case availableMarkets = "available_markets"
                case discNumber = "disc_number"
                case durationMs = "duration_ms"
                case explicit = "explicit"
                case externalIds
                case externalUrls
                case href = "href"
                case id = "id"
                case isLocal = "is_local"
                case name = "name"
                case popularity = "popularity"
                case previewUrl = "preview_url"
                case trackNumber = "track_number"
                case type = "type"
                case uri = "uri"
            }
        }
    }
    struct Image : Codable {

        let height : Int?
        let url : String?
        let width : Int?


        enum CodingKeys: String, CodingKey {
            case height = "height"
            case url = "url"
            case width = "width"
        }
    }
    struct ExternalUrl : Codable {

        let spotify : String?


        enum CodingKeys: String, CodingKey {
            case spotify = "spotify"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            spotify = try values.decodeIfPresent(String.self, forKey: .spotify)
        }
    }
    struct ExternalId : Codable {

        let isrc : String?


        enum CodingKeys: String, CodingKey {
            case isrc = "isrc"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            isrc = try values.decodeIfPresent(String.self, forKey: .isrc)
        }
    }
    struct Album : Codable {

        let albumType : String?
        let artists : [Artist]?
        let availableMarkets : [String]?
        let externalUrls : ExternalUrl?
        let href : String?
        let id : String?
        let images : [Image]?
        let name : String?
        let releaseDate : String?
        let releaseDatePrecision : String?
        let totalTracks : Int?
        let type : String?
        let uri : String?


        enum CodingKeys: String, CodingKey {
            case albumType = "album_type"
            case artists = "artists"
            case availableMarkets = "available_markets"
            case externalUrls = "externalUrls"
            case href = "href"
            case id = "id"
            case images = "images"
            case name = "name"
            case releaseDate = "release_date"
            case releaseDatePrecision = "release_date_precision"
            case totalTracks = "total_tracks"
            case type = "type"
            case uri = "uri"
        }
        

    }
    struct Artist : Codable {

        let externalUrls : ExternalUrl?
        let href : String?
        let id : String?
        let name : String?
        let type : String?
        let uri : String?


        enum CodingKeys: String, CodingKey {
            case externalUrls
            case href = "href"
            case id = "id"
            case name = "name"
            case type = "type"
            case uri = "uri"
        }

    }
}
