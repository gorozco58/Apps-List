//
//  Image.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation
import UIKit

class Image: NSObject, NSCoding {
    
    var size: CGSize
    var link: NSURL
    
    // MARK: - Enums and Structures
    private enum EncodingKey: String {
        case ImageSize = "ImageSize"
        case ImageLink = "ImageLink"
    }
    
    //MARK: - Initialization
    init(size: CGSize, link: NSURL) {
        self.size = size
        self.link = link
    }
    
    convenience init(jsonDictionary: [String : AnyObject]) throws {
        
        do {
            let heightJSON = try jsonDictionary.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            let height = try heightJSON.valueForKey(InternalParameterKey.Height.rawValue) as String
            let size = CGSize(width: CGFloat(Int(height)!), height: CGFloat(Int(height)!))
            
            let linkString = try jsonDictionary.valueForKey(InternalParameterKey.Label.rawValue) as String
            let link = NSURL(string: linkString)!
            
            self.init(size: size, link: link)
            
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
    }
    
    //MARK: - NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        
        let size = aDecoder.decodeCGSizeForKey(EncodingKey.ImageSize.rawValue)
        let link = aDecoder.decodeObjectForKey(EncodingKey.ImageLink.rawValue) as! NSURL
        
        self.init(size: size, link: link)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeCGSize(size, forKey: EncodingKey.ImageSize.rawValue)
        aCoder.encodeObject(link, forKey: EncodingKey.ImageLink.rawValue)
    }
}
