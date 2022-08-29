//
//  TrackDetailsViewController.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 28/08/2022.
//

import UIKit
import Kingfisher
protocol TrackDetailsViewToPresenter: AnyObject,LoadingViewCapable{}
final class TrackDetailsViewController: UIViewController, TrackDetailsViewToPresenter {
    
   //MARK: Outlets
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    
    //MARK: Dependencies
    lazy var presenter : TrackDetailsPresenterProtocol = TrackDetailsPresenter( service: TrackService(),view: self,item: trackItem)
    var trackItem: SearchResult.Track.Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = trackItem.album?.images?.first?.url, let imageUrl = URL(string: url){
            trackImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        }
        trackName.text = trackItem.name
    }

}

