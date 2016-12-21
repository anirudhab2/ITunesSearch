//
//  TracksCollectionViewCell.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 21/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit

// MARK: - Collection View Cell
class TracksCollectionViewCell: UICollectionViewCell {
    
    var artworkImageView: UIImageView!
    var trackNameLabel: UILabel!
    var artistNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        artworkImageView.frame = CGRect(x: 10, y: 5, width: bounds.height-10, height: bounds.height-10)
        
        let labelX = artworkImageView.frame.maxX + 10
        
        trackNameLabel.frame = CGRect(x: labelX, y: bounds.midY-30, width: bounds.width-labelX, height: 30)
        artistNameLabel.frame = trackNameLabel.frame.offsetBy(dx: 0, dy: 30)
    }
    
    private func initialize() {
        artworkImageView = UIImageView()
        self.addSubview(artworkImageView)
        
        trackNameLabel = UILabel()
        self.addSubview(trackNameLabel)
        
        artistNameLabel = UILabel()
        self.addSubview(artistNameLabel)
    }
}
