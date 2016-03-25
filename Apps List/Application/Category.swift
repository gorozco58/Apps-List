//
//  Category.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation
import Alamofire

class Category {

    var categoryId: Int
    var name: String
    var applications: [App]?
    
    init (jsonDictiondary json: [String : AnyObject]) {
        self.categoryId = 0
        self.name = ""
    }
    
    class func getAppsList(completion:(categories: [Category]) -> Void) {
    
        Alamofire.request(AlamofireRouter.Categories).validate().responseJSON { response in
            
            switch response.result {
            
            case .Success(let value):
                
                if let feed = value["feed"] as? [String : AnyObject] {
                    if let entries = feed["entry"] as? [[String : AnyObject]] {
                        categoriesAndAppsFromJsonArray(entries)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    class func categoriesAndAppsFromJsonArray(jsonArray:[[String: AnyObject]]) -> [Category] {
    
//        var categories = [Category]()
        
//        for appDictionary in jsonArray {
//        
//            let categoryDictionary =
//            let category = Category(jsonDictiondary: app)
//        }
        
        return []
    }
}
