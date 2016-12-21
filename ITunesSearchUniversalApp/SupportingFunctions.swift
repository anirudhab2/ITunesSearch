//
//  SupportingFunctions.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 21/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit

class SupportingFunctions {
    
    // Downloads Image and save it in Cache
    // If image already exists in Cache, returns image from Cache
    class func imageForUrl(urlString: String,cache:NSCache, completionHandler:(image: UIImage?, url: String) -> ()) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            let data: NSData? = cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data!)
                    cache.setObject(data!, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        })
    }
    
    // Returns a NSDate Object from time stamp string
    // NOTE: Only works for one timestamp format, can add the format in parameters if needed
    class func dateFromString(timeStamp: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return dateFormatter.dateFromString(timeStamp)
    }
    
    // Returns appropriate string for month number
    class func monthStringForMonthNumber(number: Int) -> String {
        var month = ""
        
        switch number {
        case 1:
            month = "January"
        case 2:
            month = "February"
        case 3:
            month = "March"
        case 4:
            month = "April"
        case 5:
            month = "May"
        case 6:
            month = "June"
        case 7:
            month = "July"
        case 8:
            month = "August"
        case 9:
            month = "September"
        case 10:
            month = "October"
        case 11:
            month = "November"
        case 12:
            month = "December"
        default:
            month = ""
        }
        
        return month
    }

}
