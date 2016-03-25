//
//  DictionaryTypeCast.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation

public enum KogiDictionaryCastError: ErrorType {
    case InvalidType
}

extension Dictionary  {

    public func valueForKey<ValueType>(key: Key) throws -> ValueType {
        
        guard let value = self[key] as? ValueType else {
            throw KogiDictionaryCastError.InvalidType
        }
        return value
    }
}
