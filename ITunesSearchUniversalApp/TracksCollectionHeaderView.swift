//
//  TracksCollectionHeaderView.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 22/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit

// MARK: - Section header view to show the year above search results
class TracksCollectionHeaderView: UICollectionReusableView {
    
    var headerLabel: UILabel!
    
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
        headerLabel.frame = self.bounds
    }
    
    private func initialize() {
        headerLabel = UILabel()
        headerLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(headerLabel)
        
        
        let boldFontDescriptor = headerLabel.font.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        headerLabel.font = UIFont(descriptor: boldFontDescriptor, size: 0)
    }
}
