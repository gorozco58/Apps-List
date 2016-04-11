//
//  CategoryAPI.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/30/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Alamofire

typealias ApiError = Error<ApiErrorCode>

struct Error<ErrorCode>: ErrorType {
    
    let title: String?
    let message: String?
    let code: ErrorCode?
}

extension Error {
    
    static func defaultError() -> ApiError {
        return ApiError(title: "Que ", message: "fuck", code: .ApiErrorUnknown)
    }
    
    static func apiError(error error: NSError, data: NSData?) -> ApiError {
        
        let apiErrorCode = ApiErrorCode(rawValue: error.code) ?? .ApiErrorUnknown
        let error = ApiError(title: "", message: error.localizedDescription, code: apiErrorCode)
        
        return error
    }
}

enum ApiErrorCode: Int {
    
    case ApiErrorUnknown = 0
    case ApiErrorCodeOne = 1
    case ApiErrorCodeTwo = 2
}

struct CategoryAPI {
    
    func getCategoriesList(completion:(result:(Result<[Category], ApiError>)) -> Void) {
        
        Alamofire.request(AlamofireRouter.Categories).validate().responseJSON { response in
            
            var result: Result<[Category], ApiError> = Result.Failure(ApiError.defaultError())
            
            switch response.result {
                
            case .Success(let value):
                
                if let feed = value["feed"] as? [String : AnyObject] {
                    if let entries = feed["entry"] as? [[String : AnyObject]] {
                        
                        let categories = CategoryFactory().makeCategories(entries)
                        result = Result.Success(categories)
                    }
                }
            case .Failure(let error):
                
                let error = ApiError.apiError(error: error, data: response.data)
                result = Result.Failure(error)
            }
            
            completion(result: result)
        }
    }
}

enum ImageAsset: String {

    case Logo = "logo.png"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

struct CategoryFactory {
    
    private struct CategoryKey {
        static let Category = "category"
    }
    
    func makeCategories(jsonArray:[[String: AnyObject]]) -> [Category] {
        
        var categories = [Category]()
        
        for appDictionary in jsonArray {
            
            if let categoryDictionary = appDictionary[CategoryKey.Category] as? [String : AnyObject],
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
