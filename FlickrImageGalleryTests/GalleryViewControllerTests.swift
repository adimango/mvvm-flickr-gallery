//
//  GalleryViewControllerTests.swift
//  FlickrImageGalleryTests
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import XCTest
@testable import FlickrImageGallery

class GalleryViewControllerTests: XCTestCase {
    
    var galleryViewController: GalleryViewController!
    
    override func setUp() {
        super.setUp()
        let media = FlickrMediaViewModel(flickrMedia: FlickrMedia(title: "Photo", link: "www.flicker.com/123", media: ["m":"www.flicker.com/1.jpg"], description: "Photo Description", tags: "nature"))
        let flickerMediaViewArray = Array(repeating: media, count: 5)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        galleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        galleryViewController.flickrMediaViewModelArray = flickerMediaViewArray
        XCTAssertNotNil(galleryViewController.view)
    }
    
    func testCollectionViewCells() {
        if let galleryViewController = galleryViewController {
            XCTAssertTrue(galleryViewController.flickrMediaViewModelArray?.count == 5)
            galleryViewController.collectionView.reloadData()
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
            let cells = galleryViewController.collectionView.visibleCells as! [FlickrMediaViewCell]
            for cell in cells {
                XCTAssertTrue(cell.flickrMediaViewModel?.title == "Photo", "The Cell title should be Photo")
                XCTAssertTrue(cell.flickrMediaViewModel?.mediaURL == "www.flicker.com/1.jpg", "The Cell media URL should be www.flicker.com/1.jpg")
                XCTAssertTrue(cell.flickrMediaViewModel?.tags == "Tags: nature", "The Cell tags should be Tags: nature")
            }
        }
    }
    
}
