//
//  GalleryViewController.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 10/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import UIKit
import Foundation

protocol GalleryViewDisplayLogic: class {
    func displayMediaViewModel(flickrMediaViewModel: [FlickrMediaViewModel])
    func displayError(error: String)
}

class GalleryViewController: UIViewController, GalleryViewDisplayLogic {

    // MARK: - Properties
    
    var flickrMediaViewModelArray: [FlickrMediaViewModel]?
    var galleryViewModel: GalleryViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Object lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let galleryViewModel = GalleryViewModel()
        viewController.galleryViewModel = galleryViewModel
        galleryViewModel.viewController = viewController
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        galleryViewModel?.loadMedia()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: - SetupUI
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.register(FlickrMediaViewCell.self, forCellWithReuseIdentifier:"galleryCell")
    }
    
    func displayMediaViewModel(flickrMediaViewModel: [FlickrMediaViewModel]) {
        flickrMediaViewModelArray = flickrMediaViewModel
        self.collectionView.reloadData()
    }
    
    func displayError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collections view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrMediaViewModelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! FlickrMediaViewCell
        let modiaViewModel = self.flickrMediaViewModelArray![indexPath.row]
        cell.flickrMediaViewModel = modiaViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - 20)
        return CGSize(width: itemSize, height: 200)
    }
}

