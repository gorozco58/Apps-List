//
//  CategoryAPI.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/30/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

struct CategoryAPI: CategoryService {
    
    private enum CategoryKey: String {
        case Category = "category"
    }
    
    func categoryParser(jsonArray:[[String: AnyObject]]) -> [Category] {
        
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
