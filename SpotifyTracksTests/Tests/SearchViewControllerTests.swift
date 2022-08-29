//
//  SearchViewControllerTests.swift
//  SpotifyTracksTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import XCTest
@testable import SpotifyTracks

class SearchViewControllerTests: XCTestCase {
    lazy var presenter: SearchPresenterMock? = SearchPresenterMock()
    lazy var sut : SearchTableViewController? = {
        let vc = SearchTableViewController()
        if let presenter = presenter {
            vc.presenter = presenter
        }
        return vc
    }()
    
    override func tearDown(){
        super.tearDown()
        presenter = nil
        sut = nil
    }
    func test_NumberOfRowsInSection() throws {
        // Given
        sut?.loadViewIfNeeded()
        // When
        guard let sut = sut else {
            return
        }
        let rows = sut.tableView(sut.tableView , numberOfRowsInSection: 1)
        // Then
        XCTAssertEqual(rows, 1)
    }

    func test_CellForRow_rightData() {
        // Given
        sut?.loadViewIfNeeded()
        // When
        guard let sut = sut else {
            return
        }
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TrackTableViewCell
        // Then
        XCTAssertEqual(cell?.artistName.text, "Adele")
        XCTAssertEqual(cell?.artistName.text, "Easy On Me")
    }
    func test_Search() {
        // Given
        sut?.loadViewIfNeeded()
        // When
        sut?.searchController.searchBar.text = "Adele"
        // Then
        guard let sut = sut , let presenter =  presenter else {
            return
        }
        DispatchQueue.global().asyncAfter(deadline: sut.dispatchTime ) {
            XCTAssertTrue(presenter.isSearchCalled)
        }
    }
    func test_isLoadingNextPage(){
        // Given
        sut?.loadViewIfNeeded()
        // When
        guard let sut = sut , let presenter =  presenter  else {
            return
        }
        sut.searchController.searchBar.text = "Adele"
        sut.scrollViewDidScroll(UIScrollView())

        // Then
        XCTAssertTrue(presenter.loadingNextPage)
        XCTAssertTrue(presenter.isSearchCalled)
    }
    
    func test_new_Search() {
        // Given
        sut?.loadViewIfNeeded()
        // When
        sut?.searchController.searchBar.text = "Adele"
        // Then
        guard let presenter =  presenter else {
            return
        }
        XCTAssertEqual(presenter.pageCount, 1)
    }
}
