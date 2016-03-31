//
//  ViewController.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/23/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol CategoryContent {
    
    var categories: [Category] { get }
}

class MainListViewController: UIViewController, CategoryContent {

    @IBOutlet private weak var categoriesTableView: UITableView!
    
    internal var categories: [Category] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        CategoryAPI().getCategoriesList { [unowned self] (result) in
            
            switch result {
                
            case .Success(let categories):
                
                SVProgressHUD.dismiss()
                self.categories = categories
                self.categoriesTableView.reloadData()
                
            case .Failure(let error):
                
                SVProgressHUD.showErrorWithStatus(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableViewDataSource Extension
extension MainListViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let category = categories[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.identifier, forIndexPath: indexPath) as! MainTableViewCell
        cell.titleLabel.text = category.name
        
        return cell
    }
}

//MARK: - UITableViewDelegate Extension
extension MainListViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let category = categories[indexPath.row]
        let appsVC = AppsViewController(category: category)
        navigationController?.pushViewController(appsVC, animated: true)
    }
}

