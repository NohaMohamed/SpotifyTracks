//
//  SearchViewController+TableView.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 21/08/2022.
//

import Foundation
import UIKit

extension SearchTableViewController {
    func setSearchBarView() {
        searchController.searchBar.placeholder = "Type your search here"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    func showError(message: String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension SearchTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTracks().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath)
        guard let trackCell = cell as? TrackTableViewCell  else {
            return cell
        }
        trackCell.setTrack(presenter.getTracks()[indexPath.row] )
        return trackCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let track = presenter.getTrackDetails(at: indexPath.row) else { return  }
        let trackDetails = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: .main)
        trackDetails.trackItem = track
        navigationController?.pushViewController(trackDetails, animated: false)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height , !(searchController.searchBar.text?.isEmpty ?? false) , presenter.isLoadingNextPage == false {
             presenter.loadNextPage()
         }
    }

}


