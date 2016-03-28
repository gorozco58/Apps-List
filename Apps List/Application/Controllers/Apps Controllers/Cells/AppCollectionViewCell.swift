//
//  AppCollectionViewCell.swift
//  Apps List
//
//  Created by iOS on 3/25/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit
import AlamofireImage

class AppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var progressIndicatorView: CircularLoaderView!
    
    static let identifier = "AppCollectionViewCell"
    static let nibName = "AppCollectionViewCell"
    
    //MARK: Utils
    func loadImage(imageUrl: NSURL) {
        
        appImageView.af_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "placeholder-app.png"), filter: nil, progress: { [weak self] (bytesRead, totalBytesRead, totalExpectedBytesToRead) in
            
            self?.progressIndicatorView.progress = CGFloat(totalBytesRead) / CGFloat(totalExpectedBytesToRead)
            
        }, progressQueue: dispatch_get_main_queue(), imageTransition: .None, runImageTransitionIfCached: true) { [weak self] (response) in
            
            dispatch_async(dispatch_get_main_queue(), {
                if let image = response.result.value {
                    self?.appImageView.image = image
                }
                self?.progressIndicatorView.reveal()
            })
        }
    }
}
