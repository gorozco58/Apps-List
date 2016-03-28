//
//  MainGridViewController.swift
//  Apps List
//
//  Created by iOS on 3/25/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit
import FSQCollectionViewAlignedLayout
import SVProgressHUD

class MainGridViewController: UIViewController, CategoryContent {

    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    
    internal var categories: [Category] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        registerCells()
        SVProgressHUD.show()
        
        Category.getAppsList { [unowned self] (categories, error) in
            
            if let categories = categories {
                
                SVProgressHUD.dismiss()
                self.categories = categories
                self.categoriesCollectionView.reloadData()
                
            } else if let error = error {
                
                SVProgressHUD.showErrorWithStatus(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UTils
    func setupCollectionView() {
        
        let centerLayout = FSQCollectionViewAlignedLayout()
        let attr = FSQCollectionViewAlignedLayoutSectionAttributes.withHorizontalAlignment(.Center, verticalAlignment: .Center, itemSpacing: 24, lineSpacing: 24, insets: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
        centerLayout.defaultSectionAttributes = attr
        
        categoriesCollectionView.collectionViewLayout = centerLayout;
    }
    
    func registerCells() {
        
        categoriesCollectionView.registerNib(UINib(nibName: MainCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
}

//MARK: - UICollectionViewDataSource Extension
extension MainGridViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let category = categories[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainCollectionViewCell.identifier, forIndexPath: indexPath) as! MainCollectionViewCell
        cell.titleLabel.text = category.name
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate Extension
extension MainGridViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let category = categories[indexPath.row]
        let appsVC = AppsViewController(category: category)
        navigationController?.pushViewController(appsVC, animated: true)
    }
}

//MARK: - FSQCollectionViewDelegateAlignedLayout Extension
extension MainGridViewController: FSQCollectionViewDelegateAlignedLayout {

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FSQCollectionViewAlignedLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!, remainingLineSpace: CGFloat) -> CGSize {
        
        let category = categories[indexPath.row]
        
        let cell = UINib(nibName: MainCollectionViewCell.nibName, bundle: nil).instantiateWithOwner(self, options: nil).first as! MainCollectionViewCell
        cell.updateConstraintsIfNeeded()
        cell.bounds = CGRectMake(0, 0, CGRectGetWidth(collectionView.frame), CGRectGetHeight(cell.frame))
        cell.titleLabel.text = category.name
        cell.layoutIfNeeded()
        
        let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size
    }
}
