//
//  GalleryViewModel.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import Foundation

class GalleryViewModel {
    
    // MARK: - Properties
    
    weak var viewController: GalleryViewController?
    
    func loadMedia(){
        FlickrAPI().request(path: "/services/feeds/photos_public.gne") { (response) in
            switch response {
            case .Success(let flickrMediaArray):
               self.showMedia(flickrMediaArray: flickrMediaArray)
            case .Error(let error):
               self.showError(error: error)
            }
        }
    }
    
    func showMedia(flickrMediaArray: [FlickrMedia]) {
        var flickrMediaViewModelArray = [FlickrMediaViewModel]()
        for media in flickrMediaArray {
            let flickrMediaViewModel = FlickrMediaViewModel(flickrMedia: media)
            flickrMediaViewModelArray.append(flickrMediaViewModel)
        }
        self.viewController?.displayMediaViewModel(flickrMediaViewModel: flickrMediaViewModelArray)
    }
    
    func showError(error: Error) {
        self.viewController?.displayError(error: error.localizedDescription)
    }
}
