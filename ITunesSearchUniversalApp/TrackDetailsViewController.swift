//
//  TrackDetailsViewController.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 22/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit

// MARK: - Class to show the details of the track
class TrackDetailsViewController: UIViewController {
    
    // MARK: Outlets and Variables
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var goToStoreButton: UIButton!
    
    private var track: Track!
    
    // MARK: Action
    @IBAction func goToSongInStrore(sender: AnyObject) {
        guard track != nil,
            let url = NSURL(string: track.iTunesUrl) else {
            return
        }
        
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
        if let validTrack = track {
            fillValuesForTrack(validTrack)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Method to set initial value
    func setTrack(track: Track) {
        self.track = track
    }
    
    // MARK: Private Methods
    private func fillValuesForTrack(track: Track) {
        setTitle(track.name)
        setArtist(track.artist)
        setAlbum(track.album)
        setGenre(track.genre)
        setReleasedDate(track.releaseDate)
        setArtwork(track.artworkUrlLarge)
    }
    
    private func setTitle(title: String) {
        titleLabel.text = "Title: " + title
    }
    
    private func setArtist(artist: String) {
        artistLabel.text = "Artist: " + artist
    }
    
    private func setAlbum(album: String) {
        albumLabel.text = "Album: " + album
    }
    
    private func setGenre(genre: String) {
        genreLabel.text = "Genre: " + genre
    }
    
    private func setReleasedDate(date: NSDate) {
        
        let calander = NSCalendar.currentCalendar()
        let dateComponents = calander.components([.Day, .Month, .Year], fromDate: date)
        
        releasedLabel.text = "Released: " + SupportingFunctions.monthStringForMonthNumber(dateComponents.month) + ", \(dateComponents.day), \(dateComponents.year)"
    }
    
    private func setArtwork(urlString: String) {
        SupportingFunctions.imageForUrl(urlString, cache: Constants.artworkCache) { (image, url) in
            if let validImage = image {
                self.albumArtImageView.image = validImage
            }
        }
    }

}
