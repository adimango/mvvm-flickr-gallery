//
//  FlickrMediaViewCell.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import UIKit

class FlickrMediaViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    var flickrMediaViewModel: FlickrMediaViewModel? {
        didSet {
            if let flickrMediaViewModel = flickrMediaViewModel {
                titleLabel.text = flickrMediaViewModel.title
                tagsLabel.text = flickrMediaViewModel.tags
                imageView.setImageWithURL(url: URL(string: flickrMediaViewModel.mediaURL)!)
            }
        }
    }
    
    fileprivate let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.backgroundColor = UIColor.init(red: 82/255, green: 171/255, blue: 142/255, alpha: 1)
        return image
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Object lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(tagsLabel)
        let imageWidth = frame.width * 0.4
        let imageHeight = frame.height
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(imageWidth+10)-[titleLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["titleLabel": titleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(imageWidth+10)-[tagsLabel]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["tagsLabel": tagsLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(<=\(imageHeight * 0.4))]-[tagsLabel(<=\(imageHeight * 0.5))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["titleLabel": titleLabel, "tagsLabel": tagsLabel]))
        self.backgroundColor = UIColor.white
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
