//
//  App.swift
//  Apps List
//
//  Created by iOS on 3/24/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import Foundation

enum InternalParameterKey : String {
    case Label = "label"
    case Attributes = "attributes"
    case InternalId = "im:id"
    case Height = "height"
    case Href = "href"
}

class App {
    
    //MARK: Properties
    var appId: String
    var name: String
    var image: Image
    var summary: String
    var price: Price
    var contentType: String
    var rights: String
    var title: String
    var link: NSURL
    var artist: String
    var releaseDate: String
    
    // MARK: - Enums and Structures
    private enum ParameterKey : String {
        case AppId = "id"
        case Name = "im:name"
        case Image = "im:image"
        case Summary = "summary"
        case Price = "im:price"
        case ContentType = "im:contentType"
        case Rights = "rights"
        case Title = "title"
        case Link = "link"
        case Artist = "im:artist"
        case ReleaseDate = "im:releaseDate"
    }
    
    //MARK: - Initialization
    init (jsonDictionary: [String : AnyObject]) throws {
    
        do {
            
            let appIdJSON = try jsonDictionary.valueForKey(ParameterKey.AppId.rawValue) as [String : AnyObject]
            let appIdAttributes = try appIdJSON.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            self.appId = try appIdAttributes.valueForKey(InternalParameterKey.InternalId.rawValue) as String
            
            let nameJSON = try jsonDictionary.valueForKey(ParameterKey.Name.rawValue) as [String : AnyObject]
            self.name = try nameJSON.valueForKey(InternalParameterKey.Label.rawValue) as String
            
            let imageJSON = try jsonDictionary.valueForKey(ParameterKey.Image.rawValue) as [[String : AnyObject]]
            self.image = try Image(jsonDictionary: imageJSON.last!)
            
            let summaryJSON = try jsonDictionary.valueForKey(ParameterKey.Summary.rawValue) as [String : AnyObject]
            self.summary = try summaryJSON.valueForKey(InternalParameterKey.Label.rawValue) as String
            
            let priceJSON = try jsonDictionary.valueForKey(ParameterKey.Price.rawValue) as [String : AnyObject]
            self.price = try Price(jsonDictionary: priceJSON)
            
            let contentTypeJSON = try jsonDictionary.valueForKey(ParameterKey.ContentType.rawValue) as [String : AnyObject]
            let contentTypeAttributes = try contentTypeJSON.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            self.contentType = try contentTypeAttributes.valueForKey(InternalParameterKey.Label.rawValue) as String
            
            let rightsJSON = try jsonDictionary.valueForKey(ParameterKey.Rights.rawValue) as [String : AnyObject]
            self.rights = try rightsJSON.valueForKey(InternalParameterKey.Label.rawValue) as String
            
            let titleJSON = try jsonDictionary.valueForKey(ParameterKey.Title.rawValue) as [String : AnyObject]
            self.title = try titleJSON.valueForKey(InternalParameterKey.Label.rawValue) as String
            
            let linkJSON = try jsonDictionary.valueForKey(ParameterKey.Link.rawValue) as [String : AnyObject]
            let linkAttributes = try linkJSON.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            let linkString = try linkAttributes.valueForKey(InternalParameterKey.Href.rawValue) as String
            self.link = NSURL(string: linkString)!
            
            let artistJSON = try jsonDictionary.valueForKey(ParameterKey.Artist.rawValue) as [String : AnyObject]
            self.artist = try artistJSON.valueForKey(InternalParameterKey.Label.rawValue) as String
            
            let releaseDateJSON = try jsonDictionary.valueForKey(ParameterKey.ReleaseDate.rawValue) as [String : AnyObject]
            let releaseDateAttributes = try releaseDateJSON.valueForKey(InternalParameterKey.Attributes.rawValue) as [String : AnyObject]
            self.releaseDate = try releaseDateAttributes.valueForKey(InternalParameterKey.Label.rawValue) as String
            
        } catch {
            throw InitializationError.MissingMandatoryParameters
        }
    }
}
