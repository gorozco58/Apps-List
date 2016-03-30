//
//  AppsService.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/30/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Alamofire

protocol CategoryService {
    
    func categoryParser(jsonArray: [[String: AnyObject]]) -> [Category]
    
    func getCategoriesList(completion:(result:(Result<[Category], NSError>)) -> Void)
}

extension CategoryService {

    func getCategoriesList(completion:(result:(Result<[Category], NSError>)) -> Void) {
    
        Alamofire.request(AlamofireRouter.Categories).validate().responseJSON { response in
            
            switch response.result {
                
            case .Success(let value):
                
                if let feed = value["feed"] as? [String : AnyObject] {
                    if let entries = feed["entry"] as? [[String : AnyObject]] {
                        
                        let categories = self.categoryParser(entries)
                        let result: Result<[Category], NSError> = Result.Success(categories)
                        
                        //save categories to disk
                        Category.saveCategoriesToDisk(categories)
                        
                        completion(result: result)
                    }
                }
            case .Failure(let error):
                
                let result: Result<[Category], NSError>

                //load categories from disk if exist
                if let categories = Category.loadCategoriesFromDisk() {
                    result = Result.Success(categories)
                } else {
                    result = Result.Failure(error)
                }
                
                completion(result: result)
            }
        }
    }
}
