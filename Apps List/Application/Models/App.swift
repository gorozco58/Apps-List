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

class App: NSObject, NSCoding {
    
    //MARK: Properties
    var appId: String
    var name: String
    var image: Image
    var summary: String
    var price: Price
    var contentType: String
    var rights: String
    var link: NSURL
    var artist: String
    var releaseDate: String
    
    // MARK: - Enums and Structures
    private enum ParameterKey: String {
        case AppId = "id"
        case Name = "im:name"
        case Image = "im:image"
        case Summary = "summary"
        case Price = "im:price"
        case ContentType = "im:contentType"
        case Rights = "rights"
        case Link = "link"
        case Artist = "im:artist"
        case ReleaseDate = "im:releaseDate"
    }
    
    private enum EncodingKey: String {
        case AppId = "AppId"
        case AppName = "AppName"
        case AppImage = "AppImage"
        case AppSummary = "AppSummary"
        case AppPrice = "AppPrice"
        case AppContentType = "AppContentType"
        case AppRights = "AppRights"
        case AppLink = "AppLink"
        case AppArtist = "AppArtist"
        case AppReleaseDate = "AppReleaseDate"
        
    }
    
    //MARK: - Initialization
    init(appId: String = "", name: String = "", image: Image = Image(), summary: String = "", price: Price = Price(), contentType: String = "", rights: String = "", link: NSURL = NSURL(), artist: String = "", releaseDate: String = "") {
    
        self.appId = appId
        self.name = name
        self.image = image
        self.summary = summary
        self.price = price
        self.contentType = contentType
        self.rights = rights
        self.link = link
        self.artist = artist
        self.releaseDate = releaseDate
    }
    
    convenience init (jsonDictionary: [String : AnyObject]) throws {
    
        do {
            self.init()
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
    
    //MARK: - NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        
        let appId = aDecoder.decodeObjectForKey(EncodingKey.AppId.rawValue) as! String
        let name = aDecoder.decodeObjectForKey(EncodingKey.AppName.rawValue) as! String
        let image = aDecoder.decodeObjectForKey(EncodingKey.AppImage.rawValue) as! Image
        let summary = aDecoder.decodeObjectForKey(EncodingKey.AppSummary.rawValue) as! String
        let price = aDecoder.decodeObjectForKey(EncodingKey.AppPrice.rawValue) as! Price
        let contentType = aDecoder.decodeObjectForKey(EncodingKey.AppContentType.rawValue) as! String
        let rights = aDecoder.decodeObjectForKey(EncodingKey.AppRights.rawValue) as! String
        let link = aDecoder.decodeObjectForKey(EncodingKey.AppLink.rawValue) as! NSURL
        let artist = aDecoder.decodeObjectForKey(EncodingKey.AppArtist.rawValue) as! String
        let releaseDate = aDecoder.decodeObjectForKey(EncodingKey.AppReleaseDate.rawValue) as! String
        
        self.init(appId: appId, name: name, image: image, summary: summary, price: price, contentType: contentType, rights: rights, link: link, artist: artist, releaseDate: releaseDate)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(appId, forKey: EncodingKey.AppId.rawValue)
        aCoder.encodeObject(name, forKey: EncodingKey.AppName.rawValue)
        aCoder.encodeObject(image, forKey: EncodingKey.AppImage.rawValue)
        aCoder.encodeObject(summary, forKey: EncodingKey.AppSummary.rawValue)
        aCoder.encodeObject(price, forKey: EncodingKey.AppPrice.rawValue)
        aCoder.encodeObject(contentType, forKey: EncodingKey.AppContentType.rawValue)
        aCoder.encodeObject(rights, forKey: EncodingKey.AppRights.rawValue)
        aCoder.encodeObject(link, forKey: EncodingKey.AppLink.rawValue)
        aCoder.encodeObject(artist, forKey: EncodingKey.AppArtist.rawValue)
        aCoder.encodeObject(releaseDate, forKey: EncodingKey.AppReleaseDate.rawValue)
    }
}
