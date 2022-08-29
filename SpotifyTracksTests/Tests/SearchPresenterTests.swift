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
        sut?.search("Adele")
        // Then
        XCTAssertEqual(sut?.getTracks().count, 1)
    }
    func test_searchQuery_data_isEmpty() {
        // Given
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        // When
        sut?.search("Adele")
        // Then
        XCTAssertEqual(sut?.getTracks().count, 0)
    }
    func test_searchQuery_nextPageIncremented() {
        // Given
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        // When
        sut?.search("apple")
        // Then
        XCTAssertEqual(sut?.nextPageURL, "https://api.spotify.com/v1/search?query=Adele&type=track&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&offset=10&limit=10")
    }
    func test_search_nextPageInCaseFailure(){
        // Given
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        // When
        sut?.search("apple")
        // Then
        XCTAssertNil(sut?.nextPageURL)
    }
    
    func test_search_decodeFailure(){
        // Given
        let searchResult = SearchResponseMock.getWrongResponse()
        // When
        mockSearchService?.configure(data: searchResult, error: nil)
        sut?.search("apple")
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
