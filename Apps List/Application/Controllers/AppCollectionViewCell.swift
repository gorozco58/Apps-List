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
    
    static let identifier = "AppCollectionViewCell"
    static let nibName = "AppCollectionViewCell"
    
    func loadImage(imageUrl: NSURL) {
        
        appImageView.af_setImageWithURL(imageUrl, placeholderImage: nil, filter: nil, progress: { (bytesRead, totalBytesRead, totalExpectedBytesToRead) in
            
            print("progress \(bytesRead / totalExpectedBytesToRead)")
            
            }, progressQueue: dispatch_get_main_queue(), imageTransition: .None, runImageTransitionIfCached: true) { [weak self] (response) in
                
                self?.appImageView.image = response.result.value
        }
    }
}
