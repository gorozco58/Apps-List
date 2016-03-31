//
//  CategoryAPI.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/30/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Alamofire

struct CategoryAPI {
    
    func getCategoriesList(completion:(result:(Result<[Category], NSError>)) -> Void) {
        
        Alamofire.request(AlamofireRouter.Categories).validate().responseJSON { response in
            
            switch response.result {
                
            case .Success(let value):
                
                if let feed = value["feed"] as? [String : AnyObject] {
                    if let entries = feed["entry"] as? [[String : AnyObject]] {
                        
                        let categories = CategoryFactory().makeCategories(entries)
                        let result: Result<[Category], NSError> = Result.Success(categories)
                        
                        completion(result: result)
                    }
                }
            case .Failure(let error):
                
                let result: Result<[Category], NSError> = Result.Failure(error)
                completion(result: result)
            }
        }
    }
}

struct CategoryFactory {
    
    private enum CategoryKey: String {
        case Category = "category"
    }
    
    func makeCategories(jsonArray:[[String: AnyObject]]) -> [Category] {
        
        var categories = [Category]()
        
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
                    categories += [category]
                }
            }
        }
        
        return categories
    }
}
