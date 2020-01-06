//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db = SQLiteDatabase()

//Create Posts Table
let postsTableSQL = """
CREATE TABLE Posts(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name CHAR(255) NOT NULL
);
"""
do { try db.createTable(sql: postsTableSQL) }
catch { print(db.errorMessage) }

let posts = Posts(database: db)
//for post in posts {
//  print("Post: \(post.name())")
//}
//
do {
    let post = try posts.add(title: "Oliver!")
    print("Just added post # \(post.id), \(post.title())")
}
catch {
    print(error)
}

