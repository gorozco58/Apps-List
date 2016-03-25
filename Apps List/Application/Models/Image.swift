//
//  Image.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation
import UIKit

class Image {
    
    var size: CGSize
    var link: NSURL
    
    init(jsonDictionary: [String : AnyObject]) throws {
        
        do {
        
            let heightJSON = try jsonDictionary.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            let height = try heightJSON.valueForKey(InternalParameterKey.Height.rawValue) as String
            self.size = CGSize(width: CGFloat(Int(height)!), height: CGFloat(Int(height)!))
            
            let linkString = try jsonDictionary.valueForKey(InternalParameterKey.Label.rawValue) as String
            self.link = NSURL(string: linkString)!
            
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
        
    }
}
