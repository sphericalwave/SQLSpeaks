//
//  Contacts.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

class Posts
{
    let database: SQLiteDatabase
    
    init(database: SQLiteDatabase) {
        self.database = database
    }
    
    //implement Sequence protocol
    //func next() -> Post {
    //}
    
//    func add(title: String) -> Post {
//        return Post(id: 2, name: title)
//    }
}
