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

    //MARK: - Properties
    var categoryId: String
    var name: String
    var applications: [App]
    
    // MARK: - Enums and Structures
    private enum CategoryKey : String {
        case Category = "category"
    }
    
    //MARK: - Initialization
    init (jsonDictionary: [String : AnyObject]) throws {
        
        do {
        
            self.categoryId = try jsonDictionary.valueForKey(InternalParameterKey.InternalId.rawValue) as String
            self.name = try jsonDictionary.valueForKey(InternalParameterKey.Label.rawValue) as String
            self.applications = []
            
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
    }
    
    //MARK: - Utils
    class func getAppsList(completion:(categories: [Category]?, error: NSError?) -> Void) {
    
        Alamofire.request(AlamofireRouter.Categories).validate().responseJSON { response in
            
            switch response.result {
            
            case .Success(let value):
                
                if let feed = value["feed"] as? [String : AnyObject] {
                    if let entries = feed["entry"] as? [[String : AnyObject]] {
                        
                        let categories = categoriesAndAppsFromJsonArray(entries)
                        completion(categories: categories, error: nil)
                    }
                }
            case .Failure(let error):
                
                completion(categories: nil, error: error)
            }
        }
    }
    
    private class func categoriesAndAppsFromJsonArray(jsonArray:[[String: AnyObject]]) -> [Category] {
    
        var categories: Set<Category> = Set()
        
        for appDictionary in jsonArray {
        
            if let categoryDictionary = appDictionary[CategoryKey.Category.rawValue] as? [String : AnyObject],
            let categoryAttributes = categoryDictionary[InternalParameterKey.Attributes.rawValue] as? [String : AnyObject],
            var category = try? Category(jsonDictionary: categoryAttributes) {
                
                let app = try? App(jsonDictionary: appDictionary)
                
                if categories.contains(category) {
                    if let app = app {
                        category = categories[categories.indexOf(category)!]
                        category.applications += [app]
                    }
                } else {
                    if let app = app {
                        category.applications += [app]
                    }
                    categories.insert(category)
                }
            }
        }
        
        return Array(categories)
    }
}

extension Category: Equatable {}

func ==(lhs: Category, rhs: Category) -> Bool {

    return lhs.categoryId == rhs.categoryId
}

extension Category: Hashable {

    var hashValue: Int {
        return self.categoryId.hashValue
    }
}
