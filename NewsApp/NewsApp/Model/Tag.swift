//
//  Tag.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

struct Tag {
    let name: String
    let isPrefered: Bool
    
    static func dummyTags() -> [Tag] {
        return [
            Tag(name: "Business", isPrefered: false),
            Tag(name: "Entertainment", isPrefered: false),
            Tag(name: "General", isPrefered: false),
            Tag(name: "Health", isPrefered: false),
            Tag(name: "Science", isPrefered: false),
            Tag(name: "Sports", isPrefered: false),
            Tag(name: "Technology", isPrefered: false)
        ]
    }
}
