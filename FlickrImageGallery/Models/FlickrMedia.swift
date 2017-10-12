//
//  FlickrMedia.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import Foundation

struct FlickrMedia: Codable {
    
    // MARK: - Properties

    let title: String
    let link: String
    let media: [String:String]
    let description: String
    let tags: String?
}
