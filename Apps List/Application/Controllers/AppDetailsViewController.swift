//
//  AppDetailsViewController.swift
//  Apps List
//
//  Created by iOS on 3/25/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit

class AppDetailsViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rightsLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var contentTypeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    private var app: App
    
    init(app: App) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupAppInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAppInformation() {
        
        let blurEffect = UIBlurEffect(style: .Light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.addSubview(visualEffectView)
        
        let views = ["effectView" : visualEffectView]
        backgroundImageView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[effectView]|", options: .AlignAllLeading, metrics: nil, views: views))
        backgroundImageView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[effectView]|", options: .AlignAllLeading, metrics: nil, views: views))
        
        backgroundImageView.af_setImageWithURL(app.image.link)
        appImageView.af_setImageWithURL(app.image.link)
        appNameLabel.text = app.name
        descriptionLabel.text = app.summary
        rightsLabel.text = app.rights
        artistLabel.text = app.artist
        contentTypeLabel.text = app.contentType
        releaseDateLabel.text = app.releaseDate
        priceLabel.text = app.price.priceString
        linkButton.setTitle(app.link.absoluteString, forState: .Normal)
    }

    @IBAction func linkButtonPressed(sender: UIButton) {
    
    }
}
