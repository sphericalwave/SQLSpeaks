//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db = SQLiteDatabase()

do { try db.createTable(table: Post.self) }
catch { print(db.errorMessage) }

do { try db.insertPost(contact: Post(id: 1, name: "Electro Magnetic Ray")) }
catch { print(db.errorMessage) }

if let aContact = db.contact(id: 1) {
    print("\(aContact.id) \(aContact.name)")
}

//let posts = Posts(db)
//for post in posts {
//  print("Post: \(post.name())")
//}
//
// let post = posts.add(2, "name")
//print("Just added post # \(post.id())")
