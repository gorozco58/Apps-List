//
//  ViewController.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/23/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Category.getAppsList { (categories, error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

