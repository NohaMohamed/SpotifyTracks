//
//  TrackTableViewCell.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 18/08/2022.
//

import UIKit
import Kingfisher

class TrackTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTrack(_ track: TrackUIModel){
        if let url = track.imageUrl, let imageUrl = URL(string: url){
            albumImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        }
        trackName.text = track.trackName
        artistName.text = track.artistName
    }
}
