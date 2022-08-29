//
//  AuthenticationModel.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 22/08/2022.
//
import Foundation

struct RefreshTokenModel : Codable {

    let accessToken : String?
    let expiresIn : Int
    let scope : String?
    let tokenType : String?


    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case scope = "scope"
        case tokenType = "token_type"
    }

}
struct AuthenticationModel : Codable {

	let accessToken : String?
	let expiresIn : Int
	let refreshToken : String?
	let scope : String?
	let tokenType : String?


	enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
		case expiresIn = "expires_in"
		case refreshToken = "refresh_token"
		case scope = "scope"
		case tokenType = "token_type"
	}

}
struct UserAuthentication {
    let accessToken : String
    let expiresDate : Date
    let refreshToken : String
}
