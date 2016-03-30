//
//  Category.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation
import Alamofire

private let CategoriesPath = "categories.obj"

class Category: NSObject, NSCoding {

    //MARK: - Properties
    var categoryId: String
    var name: String
    var applications: [App]
    
    // MARK: - Enums and Structures   
    private enum EncodingKey: String {
        case CategoryId = "CategoryId"
        case CategoryName = "CategoryName"
        case CategoryApps = "CategoryApps"
    }
    
    //MARK: - Initialization
    init(categoryId: String, name: String, applications: [App]) {
        self.categoryId = categoryId
        self.name = name
        self.applications = applications
        super.init()
    }
    
    convenience init (jsonDictionary: [String : AnyObject]) throws {
        
        do {
            let categoryId = try jsonDictionary.valueForKey(InternalParameterKey.InternalId.rawValue) as String
            let name = try jsonDictionary.valueForKey(InternalParameterKey.Label.rawValue) as String
            self.init(categoryId: categoryId, name: name, applications: [])
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
    }
    
    //MARK: - NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        
        let categoryId = aDecoder.decodeObjectForKey(EncodingKey.CategoryId.rawValue) as! String
        let name = aDecoder.decodeObjectForKey(EncodingKey.CategoryName.rawValue) as! String
        let applications = aDecoder.decodeObjectForKey(EncodingKey.CategoryApps.rawValue) as! [App]
        
        self.init(categoryId: categoryId, name: name, applications: applications)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(categoryId, forKey: EncodingKey.CategoryId.rawValue)
        aCoder.encodeObject(name, forKey: EncodingKey.CategoryName.rawValue)
        aCoder.encodeObject(applications, forKey: EncodingKey.CategoryApps.rawValue)
    }
    
    //MARK: - Utils
    override func isEqual(object: AnyObject?) -> Bool {
        
        return self.categoryId == (object as! Category).categoryId
    }
}

extension Category {

    class func saveCategoriesToDisk(categories: [Category]) -> Bool {
        
        let urlPath = Category.categoriesPath()
        let dataToSave = NSKeyedArchiver.archivedDataWithRootObject(categories)
        let success = dataToSave.writeToURL(urlPath, atomically: true)
        
        return success
    }
    
    class func loadCategoriesFromDisk() -> [Category]? {
        
        let urlPath = Category.categoriesPath()
        var categories: [Category]?
        
        if let data = NSData(contentsOfURL: urlPath) {
            
            categories = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Category]
        }
        
        return categories
    }
    
    private class func categoriesPath() -> NSURL {
    
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDict = NSURL(fileURLWithPath: paths.first!)
        let urlPath = documentsDict.URLByAppendingPathComponent(CategoriesPath)
    
        return urlPath
    }
}
