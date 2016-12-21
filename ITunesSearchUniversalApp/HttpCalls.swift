//
//  HttpCalls.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 21/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HttpCalls: NSObject {

    func getTracksForSearchTerm(term: String, completion: (statusCode: Int, trackList: [Track]) -> ()) {
        let url = Constants.rootUrl
        let params: [String: AnyObject] = ["term": term, "entity": "song"]
        
        Alamofire.request(.GET, url, parameters: params).response { request, response, data, error in
            if (error != nil) {
                print("Error in getting track list: \(error)")
                completion(statusCode: error!.code, trackList: [])
            } else {
                let statusCode = response!.statusCode
                let json = JSON(data: data!)
                
                var trackList: [Track] = []
                
                for item in json[Constants.jsonKeys.results].arrayValue {
                    let newTrack = Track()
                    newTrack.artist = item[Constants.jsonKeys.artistName].stringValue
                    newTrack.name = item[Constants.jsonKeys.trackName].stringValue
                    newTrack.album = item[Constants.jsonKeys.collectionName].stringValue
                    newTrack.genre = item[Constants.jsonKeys.primaryGenreName].stringValue
                    newTrack.releaseDateTimeStamp = item[Constants.jsonKeys.releaseDate].stringValue
                    newTrack.artworkUrlSmall = item[Constants.jsonKeys.artworkUrl60].stringValue
                    newTrack.artworkUrlLarge = item[Constants.jsonKeys.artworkUrl100].stringValue
                    newTrack.iTunesUrl = item[Constants.jsonKeys.trackViewUrl].stringValue
                    
                    trackList.append(newTrack)
                }
                
                completion(statusCode: statusCode, trackList: trackList)
            }
        }
    }
    
}
