//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db = SQLiteDatabase()
//let posts = Posts(database: db)
//
//do {
//    let post = try posts.add(title: "Keeg!")
//    print("Just added post # \(post.id), \(post.title())")
//}
//catch { print(error) }
//print("Post count: \(posts.count())")
//for post in posts { print("Post #: \(post.id), title: \(post.title())") }
//
//let users = Users(database: db)

let governers = Governers(database: db)
      //let addGoverner = "INSERT INTO Governers(GID, Name, Address, TermBegin) values(110, 'Bob', '123 Any St', '1-Jan-2009');"
try! governers.add(id: 112, name: "Arnold", address: "California", termBegin: "1-Jan-2009")

