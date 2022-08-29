//
//  TrackDetailsPresenter.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 29/08/2022.
//

import Foundation

protocol TrackDetailsPresenterProtocol {
    func getTrackDetails(_ id: String)
}
final class TrackDetailsPresenter {
    //MARK: Properties
    var service: TrackServiceProtocol
    var track: SearchResult.Track.Item?
    weak var view: TrackDetailsViewToPresenter?
    
    init(service: TrackServiceProtocol,view: TrackDetailsViewToPresenter, item: SearchResult.Track.Item) {
        self.service = service
        self.view = view
    }
    //TODO: implement refresh
    func getTrackDetails(_ id: String){
        self.view?.showLoading()
        service.getTrackDetails(id: id) { [weak self] result in
            self?.view?.hideLoading()
            switch result{
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}
extension TrackDetailsPresenter :TrackDetailsPresenterProtocol{
    
    
}
