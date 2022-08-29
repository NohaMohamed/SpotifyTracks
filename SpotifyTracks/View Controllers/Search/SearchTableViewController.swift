//
//  SearchViewController.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 18/08/2022.
//

import UIKit
protocol SearchViewProtocol : AnyObject ,LoadingViewCapable{
    func didRecieveTracks()
    func didRecieveError(_ message: String)
}
final class SearchTableViewController: UITableViewController {
    
    //MARK: Dependencies
    private var searchTask: DispatchWorkItem?
    let cellIdentifier: String = "TrackTableViewCell"
    let dispatchTime: DispatchTime = DispatchTime.now() + .seconds(5)
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var presenter : SearchPresenterToViewProtocol = {
        let searchPresenter = SearchPresenter(service: SearchService())
        searchPresenter.view = self
        return searchPresenter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setSearchBarView()
    }
    private func setupTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchTableViewController: SearchViewProtocol{
    func didRecieveError(_ message: String) {
        showError(message: message)
    }
    
    func didRecieveTracks() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
// Search Logic
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBarText = searchController.searchBar.text
        self.presenter.resetTracks()
        self.searchTask?.cancel()
        guard let text = searchBarText, !text.isEmpty else {
            return
        }
        let task = DispatchWorkItem { [weak self] in
            self?.presenter.search(text)
        }
        self.searchTask = task
        //End previous search task aand send another reuquest after 0.5
        DispatchQueue.global().asyncAfter(deadline: dispatchTime, execute: task)

    }
}
