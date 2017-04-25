//
//  NewsData.swift
//  MOJ
//
//  Created by CBK-Admin on 4/25/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON
class NewsData: NSObject {
    
    var userdefault = UserDefaults.standard
    
    let KEY_NEWS_DATA = "data"
    let KEY_NEWS_GROUP_ID = "newsgrpid"
    let KEY_NEWS_THUMPNAIL = "newsthumb"
    let KEY_NEWS_TITLE = "newstitle"
    let KEY_NEWS_URL = "newsurl"
    let KEY_NEWS_LAST_UPDATE = "lastupd"
    
    func getNewsData(json:Any){
        
        let swiftyJson = JSON(json)
        let newsgrpid = swiftyJson[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_GROUP_ID].intValue})
        let lastupd = swiftyJson[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_LAST_UPDATE].stringValue})
        let newsthumb = swiftyJson[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_THUMPNAIL].stringValue})
        let newstitle = swiftyJson[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_TITLE].stringValue})
        let newsurl = swiftyJson[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_URL].stringValue})
        
        
        setNewsGroupID(groupID: newsgrpid)
        setLastUpdate(lastUpdate: lastupd)
        setTitle(title: newstitle)
        setUrl(url: newsurl)
        setThumbnail(thumbnail: newsthumb)
    }
    
    // groupid
    func setNewsGroupID(groupID:[Int]){
        userdefault.set(groupID, forKey: KEY_NEWS_GROUP_ID)
    }
    
    func getNewsGroupID()->[Int]{
        return userdefault.array(forKey: KEY_NEWS_GROUP_ID) as! [Int]
    }
    
    // lastupdate
    func setLastUpdate(lastUpdate:[String]){
        userdefault.set(lastUpdate, forKey: KEY_NEWS_LAST_UPDATE)
    }
    
    func getLastUpdate()->[String]{
        return userdefault.array(forKey: KEY_NEWS_LAST_UPDATE) as! [String]
    }
    
    // title
    func setTitle(title:[String]){
        userdefault.set(title, forKey: KEY_NEWS_TITLE)
    }
    
    func getTitle()->[String]{
        return userdefault.array(forKey: KEY_NEWS_TITLE) as! [String]
    }
    
    // thumbnail
    func setThumbnail(thumbnail:[String]){
        userdefault.set(thumbnail, forKey: KEY_NEWS_THUMPNAIL)
    }
    
    func getThumbnail()->[String]{
        return userdefault.array(forKey: KEY_NEWS_THUMPNAIL) as! [String]
    }
    
    // url
    func setUrl(url:[String]){
        userdefault.set(url, forKey: KEY_NEWS_URL)
    }
    
    func getUrl()->[String]{
        return userdefault.array(forKey: KEY_NEWS_URL) as! [String]
    }
}
