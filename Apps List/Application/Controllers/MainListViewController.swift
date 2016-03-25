//
//  ViewController.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/23/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainListViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        Category.getAppsList { [unowned self] (categories, error) in
            
            if let error = error {
                
                SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                
            } else if let categories = categories {
            
                SVProgressHUD.dismiss()
                self.categories = categories
                self.categoriesTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

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

extension MainListViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

