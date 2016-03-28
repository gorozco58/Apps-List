//
//  Price.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation

class Price: NSObject, NSCoding {
    
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
    
    private enum EncodingKey: String {
        case PriceAmount = "PriceAmount"
        case PriceCurrency = "PriceCurrency"
    }
    
    //MARK: - Initialization
    init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    convenience init(jsonDictionary: [String : AnyObject]) throws {
        
        do {
            let priceJSON = try jsonDictionary.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            let amount = try priceJSON.valueForKey(PriceKey.Amount.rawValue) as String
            let currency = try priceJSON.valueForKey(PriceKey.Currency.rawValue) as String
            
            self.init(amount: amount, currency: currency)
            
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
    }
    
    //MARK: - NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        
        let amount = aDecoder.decodeObjectForKey(EncodingKey.PriceAmount.rawValue) as! String
        let currency = aDecoder.decodeObjectForKey(EncodingKey.PriceCurrency.rawValue) as! String
        
        self.init(amount: amount, currency: currency)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(amount, forKey: EncodingKey.PriceAmount.rawValue)
        aCoder.encodeObject(currency, forKey: EncodingKey.PriceCurrency.rawValue)
    }
}
