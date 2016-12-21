//
//  TrackListViewController.swift
//  ITunesSearchUniversalApp
//
//  Created by Anirudha Tolambia on 21/12/16.
//  Copyright © 2016 Anirudha Tolambia. All rights reserved.
//

import UIKit
import JGProgressHUD

class TrackListViewController: UIViewController {
    
    // MARK: Outlets and Variables
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tracksCollectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private var trackList: [[Track]] = []

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout.estimatedItemSize = CGSize(width: view.bounds.width, height: Constants.trackCollectionCellHeight)
        flowLayout.headerReferenceSize.height = Constants.trackCollectionSectionHeaderHeight
        
        tracksCollectionView.dataSource = self
        tracksCollectionView.delegate = self
        tracksCollectionView.backgroundColor = UIColor.clearColor()
        
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if (searchBar.isFirstResponder()) {
            searchBar.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        flowLayout.invalidateLayout()
        flowLayout.estimatedItemSize = CGSizeMake(view.bounds.width, Constants.trackCollectionCellHeight)
        flowLayout.headerReferenceSize.height = Constants.trackCollectionSectionHeaderHeight
    }
    
    func viewTapped() {
        if (searchBar.isFirstResponder()) {
            searchBar.resignFirstResponder()
        }
    }
}

// MARK: Collection View DataSource and Delegates
extension TrackListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return trackList.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackList[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.identifiers.collectionCellIdentifier, forIndexPath: indexPath) as! TracksCollectionViewCell
        
        let track = trackList[indexPath.section][indexPath.row]
        
        cell.trackNameLabel.text = track.name
        cell.artistNameLabel.text = track.artist
        
        let artworkUrl = track.artworkUrlLarge
        cell.artworkImageView.image = nil
        
        SupportingFunctions.imageForUrl(artworkUrl, cache: Constants.artworkCache) { (image, url) in
            if let validImage = image {
                if (artworkUrl == url) {
                    cell.artworkImageView.image = validImage
                }
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let track = trackList[indexPath.section][indexPath.row]
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.identifiers.trackDetailsVcIdentifier) as! TrackDetailsViewController
        vc.setTrack(track)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: Constants.identifiers.sectionHeaderViewIdentifier, forIndexPath: indexPath) as! TracksCollectionHeaderView
            
            if let track = trackList[indexPath.section].first {
                headerView.headerLabel.text = "\(track.releaseYear)"
            }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (trackList[section].count > 0) {
            return flowLayout.headerReferenceSize
        }
        
        return CGSizeZero
    }
}

// MARK: Search Bar Delegate
extension TrackListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        getSearchResultsForText(searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

// MARK: Getting and Parsing the data
extension TrackListViewController {
    private func getSearchResultsForText(text: String) {
        
        let hud = JGProgressHUD(style: .Light)
        hud.showInView(view)
        
        trackList.removeAll()
        tracksCollectionView.reloadData()
        
        let calls = HttpCalls()
        calls.getTracksForSearchTerm(text) { (statusCode, trackList) in
            
            hud.dismiss()
            
            if (statusCode >= 200 && statusCode < 300) {
                
                let sortedList = trackList.sort({ $0.releaseDate.compare($1.releaseDate) == NSComparisonResult.OrderedDescending })
                self.trackList = self.parseTrackList(sortedList)
                self.tracksCollectionView.reloadData()
            } else {
                // Should handle failure case here
                // Right now just showing an alert controller
                // Should handle appropriately according to API response
                
                dispatch_async(dispatch_get_main_queue(), { 
                    let message = "Couldn't load search results, please try again"
                    
                    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
                    let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(okayAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)

                })
            }
        }
    }
    
    private func parseTrackList(list: [Track]) -> [[Track]]{
        var parsedArray: [[Track]] = []
        
        if (list.count > 0) {
            
            let dummyArray: [Track] = []
            parsedArray.append(dummyArray)
            parsedArray[0].append(list.first!)
            
            var currentIndex = 0
            
            for i in 1..<list.count {
                if (list[i].releaseYear != list[i-1].releaseYear) {
                    currentIndex += 1
                    parsedArray.append(dummyArray)
                }
                
                parsedArray[currentIndex].append(list[i])
            }
        }
        
        return parsedArray
    }
}

