//
//  Constants.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 21/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit

class Constants {
    
    static let rootUrl = "https://itunes.apple.com/search"
    
    static let jsonKeys = JsonKeys()
    static let identifiers = Identifiers()
    
    static let trackCollectionCellHeight: CGFloat = 100.0
    static let trackCollectionSectionHeaderHeight: CGFloat = 40.0
    
    
    static let artworkCache = NSCache()
}

class JsonKeys {
    let results = "results"
    let artistName = "artistName"
    let trackName = "trackName"
    let collectionName = "collectionName"
    let primaryGenreName = "primaryGenreName"
    let releaseDate = "releaseDate"
    let artworkUrl30 = "artworkUrl30"
    let artworkUrl60 = "artworkUrl60"
    let artworkUrl100 = "artworkUrl100"
    let trackViewUrl = "trackViewUrl"
}

class Identifiers {
    let collectionCellIdentifier = "CollectionCell"
    let sectionHeaderViewIdentifier = "HeaderView"
    let trackDetailsVcIdentifier = "TrackDetailsViewController"
}