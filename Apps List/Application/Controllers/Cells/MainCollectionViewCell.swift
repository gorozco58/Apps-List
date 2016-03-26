//
//  MainCollectionViewCell.swift
//  Apps List
//
//  Created by iOS on 3/26/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "MainCollectionViewCell"
    static let nibName = "MainCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
