//
//  AlamofireRouter.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation
import Alamofire

enum InitializationError: ErrorType {
    
    case MissingMandatoryParameters
}

enum AlamofireRouter: URLRequestConvertible {

    static let baseURLString = "https://itunes.apple.com/"
    
    //MARK: - Cases
    case Categories
    
    // MARK: - Method
    var method: Alamofire.Method {
        switch self {
        case .Categories:
            return .GET
        }
    }
        
    // MARK: - Path
    var path: String {
        switch self {
        case .Categories:
            return "us/rss/topfreeapplications/limit=100/json"
        }
    }
        
    // MARK: - URLRequest
    var URLRequest: NSMutableURLRequest {
            
        let url = NSURL(string: AlamofireRouter.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
            
        return mutableURLRequest
    }
}
