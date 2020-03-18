//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db = SQLiteDatabase()

//FIXME: Encapsulate inside Posts
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

//Add a Post to Posts
do {
    let post = try posts.add(title: "Keeg!")
    print("Just added post # \(post.id), \(post.title())")
}
catch { print(error) }

print("Post count: \(posts.count())")

for post in posts {
    print("Post #: \(post.id), title: \(post.title())")
}


let supplierSql = """
CREATE TABLE suppliers (
    supplier_id integer PRIMARY KEY,
    supplier_name text NOT NULL,
    group_id integer NOT NULL
);
"""
 
let supplierGroupSql = """
CREATE TABLE supplier_groups (
    group_id integer PRIMARY KEY,
    group_name text NOT NULL
);
"""
