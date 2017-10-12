//
//  FlickrAPITests.swift
//  FlickrImageGalleryTests
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import XCTest
@testable import FlickrImageGallery

class FlickrAPITests: XCTestCase {
    
    var flickrAPI: FlickrAPI!
    
    override func setUp() {
        super.setUp()
        flickrAPI = FlickrAPI()
        XCTAssertNotNil(flickrAPI)
    }
    
    func testFlickrAPIRequest() {
        if let flickrAPI = flickrAPI {
            let path = "/services/feeds/photos_public.gne"
            var result: ResultType?
            let completion = expectation(description: "Completion handler invoked")
            flickrAPI.request(path: path) { (response) in
                result = response
                completion.fulfill()
            }
            waitForExpectations(timeout: 3, handler: nil)
            guard case .Success? = result else {
                XCTAssertTrue(false, "Media parsing failed")
                return
            }
        }
    }
}
