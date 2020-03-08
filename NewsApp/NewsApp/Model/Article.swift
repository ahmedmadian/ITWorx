//
//  Article.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

extension Article: Persistable {
    static var entityName: String {
        return "Article"
    }
    
    static var primaryAttributeName: String {
        return "title"
    }
    
    var identity: String {
        return title
    }
    
    init(entity: NSManagedObject) {
        author = entity.value(forKey: "author") as? String
        title = entity.value(forKey: "title") as! String
        articleDescription = entity.value(forKey: "articleDescription") as! String
        url = entity.value(forKey: "url") as! String
        urlToImage = entity.value(forKey: "urlToImage") as! String
        publishedAt = entity.value(forKey: "publishedAt") as! String
        content = entity.value(forKey: "content") as? String
        source = entity.value(forKey: "source") as! Source
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(author, forKey: "author")
        entity.setValue(title, forKey: "title")
        entity.setValue(articleDescription, forKey: "articleDescription")
        entity.setValue(url, forKey: "url")
        entity.setValue(urlToImage, forKey: "urlToImage")
        entity.setValue(publishedAt, forKey: "publishedAt")
        entity.setValue(content, forKey: "content")
        entity.setValue(source, forKey: "source")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
    typealias T = NSManagedObject
    
}
