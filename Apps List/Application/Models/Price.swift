//
//  Price.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation

class Price {
    
    var amount: String
    var currency: String
    var priceString: String {
        get {
            return "\(amount) \(currency)"
        }
    }
    
    // MARK: - Enums and Structures
    private enum PriceKey : String {
        case Amount = "amount"
        case Currency = "currency"
    }
    
    init(jsonDictionary: [String : AnyObject]) throws {
        
        do {
            
            let priceJSON = try jsonDictionary.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            self.amount = try priceJSON.valueForKey(PriceKey.Amount.rawValue) as String
            self.currency = try priceJSON.valueForKey(PriceKey.Currency.rawValue) as String
            
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
    }
}
