//
//  Track.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 21/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit

// MARK: -  Model Class
class Track: NSObject {
    
    var artist: String = ""
    var name: String = ""
    var album: String = ""
    var genre: String = ""
    var releaseDateTimeStamp: String = ""
    var artworkUrlSmall: String = ""
    var artworkUrlLarge: String = ""
    var iTunesUrl: String = ""
    
    // MARK: Read Only Properties
    var releaseDate: NSDate {
        get {    
            if let validDate = SupportingFunctions.dateFromString(releaseDateTimeStamp) {
                return validDate
            } else {
                // Returning present date here if date is empty or invalid,
                // can handle it according to requirements
                return NSDate()
            }
        }
    }
    
    var releaseYear: Int {
        get {
            let calender = NSCalendar.currentCalendar()
            return calender.component(NSCalendarUnit.Year, fromDate: releaseDate)
        }
    }
}
