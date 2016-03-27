//
//  AppDetailsViewController.swift
//  Apps List
//
//  Created by iOS on 3/25/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit
import SafariServices

class AppDetailsViewController: UIViewController {

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var appImageView: UIImageView!
    @IBOutlet private weak var appNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var rightsLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var contentTypeLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var linkButton: UIButton!
    
    private var app: App
    
    //MARK: Initializers
    init(app: App) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupAppInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Utils
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

    //MARK: - Actions
    @IBAction func linkButtonPressed(sender: UIButton) {
    
        if #available(iOS 9.0, *) {
            let vc = SFSafariViewController(URL: app.link, entersReaderIfAvailable: true)
            presentViewController(vc, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(app.link)
        }
    }
    
    @IBAction func gobackButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
