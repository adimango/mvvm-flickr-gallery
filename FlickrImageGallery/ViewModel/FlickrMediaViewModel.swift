//
//  FlickrMediaViewModel.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import Foundation

struct FlickrMediaViewModel {
    
    // MARK: - Properties

    let title: String
    let mediaURL: String
    let description: String
    let tags: String?
    
    // MARK: - Object lifecycle

    init(flickrMedia: FlickrMedia) {
        title = flickrMedia.title.uppercased()
        mediaURL = flickrMedia.media["m"]!
        description = flickrMedia.description
        tags = "Tags: " + (flickrMedia.tags ?? "")
    }
}
