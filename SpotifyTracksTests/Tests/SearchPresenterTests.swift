//
//  SearchPresenterTests.swift
//  SpotifyTracksTests
//
//  Created by Noha Mohamed on 18/08/2022.
//

import XCTest
import NetworkingLayer
@testable import SpotifyTracks

class SearchPresenterTests: XCTestCase {
    var mockSearchService : SearchServiceMock? = SearchServiceMock()
    lazy var sut : SearchPresenter? = {
        guard let service = mockSearchService else{
            return nil
        }
        let presenter = SearchPresenter(service: service)
        return presenter
    }()
    
    override func tearDown(){
        super.tearDown()
        mockSearchService = nil
        sut = nil
    }
    func test_searchData_isNotEmpty(){
        // Given
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        // When
        sut?.search("Hello")
        // Then
        XCTAssertEqual(sut?.getTracks().count, 1)
    }
    func test_searchQuery_data_isEmpty() {
        // Given
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        // When
        sut?.search("Hello")
        // Then
        XCTAssertEqual(sut?.getTracks().count, 0)
    }
    func test_searchQuery_nextPageURL() {
        // Given
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        // When
        sut?.search("Hello")
        // Then
        XCTAssertEqual(sut?.nextPageURL, "https://api.spotify.com/v1/search?query=Hello&type=track&locale=ar&offset=10&limit=10")
    }
    func test_search_nextPageInCaseFailure(){
        // Given
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        // When
        sut?.search("Hello")
        // Then
        XCTAssertNil(sut?.nextPageURL)
    }
    
    func test_search_decodeFailure(){
        // Given
        let searchResult = SearchResponseMock.getWrongResponse()
        // When
        mockSearchService?.configure(data: searchResult, error: nil)
        sut?.search("Hello")
        // Then
        XCTAssertEqual(sut?.errorMessage, CustomNetworkError.canNotDecodeObject.localizedDescription)
    }
    func test_map(){
        // Given
        let apiModel = SearchResponseMock.getTrack()
        // When
        let uiModel = sut?.mapUIModel(track: apiModel)
        // Then
        XCTAssertEqual(uiModel?.trackName, apiModel.name)
        XCTAssertEqual(uiModel?.popularity, apiModel.popularity)
        }
    }
