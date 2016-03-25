//
//  AppsViewController.swift
//  Apps List
//
//  Created by iOS on 3/25/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var appsCollectionView: UICollectionView!
    
    private var category: Category
    private var apps: [App]
    
    init(category: Category) {
        
        self.category = category
        self.apps = category.applications
        super.init(nibName: nil, bundle: nil)
        self.title = category.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupCollectionView()
        registerCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 24
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        layout.itemSize = CGSize(width: 100, height: 100)
        appsCollectionView.collectionViewLayout = layout
    }
    
    func registerCells() {
        
        appsCollectionView.registerNib(UINib(nibName: AppCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: AppCollectionViewCell.identifier)
    }
}

extension AppsViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return apps.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let app = apps[indexPath.row]
        
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier(AppCollectionViewCell.identifier, forIndexPath: indexPath) as! AppCollectionViewCell
        cell.loadImage(app.image.link)
        
        return cell
    }
}

extension AppsViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}
