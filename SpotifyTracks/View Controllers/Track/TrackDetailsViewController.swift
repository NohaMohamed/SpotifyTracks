//
//  TrackDetailsViewController.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 28/08/2022.
//

import UIKit
import Kingfisher
import AVFoundation
protocol TrackDetailsViewToPresenter: AnyObject,LoadingViewCapable{}
final class TrackDetailsViewController: UIViewController, TrackDetailsViewToPresenter {
    
   //MARK: Outlets
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    
    //MARK: Dependencies
    lazy var presenter : TrackDetailsPresenterProtocol = TrackDetailsPresenter( service: TrackService(),view: self,item: trackItem)
    private var playerView :AVPlayer?
    var trackItem: SearchResult.Track.Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView(){
        if let url = trackItem.album?.images?.first?.url, let imageUrl = URL(string: url){
            trackImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        }
        trackName.text = trackItem.name
        artistName.text = trackItem.artists?.first?.name
    }
//    TODO: Due to licensing reasons, we cannot get a direct link to a full song.
    @IBAction func playAction(_ sender: Any) {
        guard let url = URL(string: trackItem.previewUrl ?? "") else { return  }
        playerView = AVPlayer(url: url)
        playerView?.play()
    }
}

