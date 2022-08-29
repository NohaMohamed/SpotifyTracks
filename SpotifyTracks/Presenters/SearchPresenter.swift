//
//  SearchPresenter.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation

protocol SearchPresenterToViewProtocol {
    func search(_ text: String)
    func getTracks() -> [TrackUIModel]
    func getTrackDetails(at row: Int) -> SearchResult.Track.Item?
    func loadNextPage()
    var isLoadingNextPage : Bool {get set}
    func resetTracks()
}
final class SearchPresenter {
    
    //MARK: Dependencies
    
    weak var view: SearchViewProtocol?
    var service : SearchServiceProtocol?
    
    //MARK: Properties
    
    var nextPageURL: String?
    private var tracks = [TrackUIModel]()
    private var trackAPIDetails: [SearchResult.Track.Item]?
    var errorMessage: String?
    var isLoadingNextPage = false
    
    init(service: SearchServiceProtocol) {
        self.service = service
    }
    func mapUIModel(track: SearchResult.Track.Item) -> TrackUIModel{
        return TrackUIModel(trackName: track.name, artistName: track.artists?[0].name, popularity: track.popularity, imageUrl: track.album?.images?.first?.url)
    }
}
extension SearchPresenter: SearchPresenterToViewProtocol{
    
    func search(_ query: String) {
        view?.showLoading()
            service?.fetchSearchResult(query: query) { [weak self] result in
                self?.view?.hideLoading()
                switch result{
                case .success(let model):
                    guard let self = self, let items = model.tracks?.items , items.count > 0 else {
                            return
                        }
                    self.nextPageURL = model.tracks?.next
                    self.trackAPIDetails = items
                    self.tracks = items.map(self.mapUIModel(track:))
                    self.view?.didRecieveTracks()
                case .failure(let error):
                    self?.reseTracks()
                    self?.errorMessage = error.localizedDescription
                    self?.view?.didRecieveError(error.localizedDescription)
                }
        }
        
    }
    func loadNextPage(){
        guard let nextPage = nextPageURL else {
            return
        }
        view?.showLoading()
        isLoadingNextPage = true
        service?.loadNextPage(url: nextPage, compeletion: { [weak self] result in
            self?.view?.hideLoading()
            self?.isLoadingNextPage = false
            switch result{
            case .success(let model):
                guard let self = self, let items = model.tracks?.items , items.count > 0 else {
                        return
                    }
                self.nextPageURL = model.tracks?.next
                self.trackAPIDetails?.append(contentsOf: items)
                self.tracks.append(contentsOf: items.map(self.mapUIModel(track:)))
                self.view?.didRecieveTracks()
            case .failure(let error):
                self?.reseTracks()
                self?.errorMessage = error.localizedDescription
                self?.view?.didRecieveError(error.localizedDescription)
            }
        })
    }
    func getTrackDetails(at row: Int) -> SearchResult.Track.Item? {
        return trackAPIDetails?[row]
    }
    

    func getTracks() -> [TrackUIModel] {
        return tracks
    }
    func resetTracks() {
        tracks = []
        view?.didRecieveTracks()
    }
    func reseTracks() {
        tracks = []
        self.view?.didRecieveTracks()
    }
}
