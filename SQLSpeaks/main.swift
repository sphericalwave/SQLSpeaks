//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db = SQLiteDatabase()
let posts = Posts(database: db)

do {
    let post = try posts.add(title: "Keeg!")
    print("Just added post # \(post.id), \(post.title())")
}
catch { print(error) }

print("Post count: \(posts.count())")

for post in posts {
    print("Post #: \(post.id), title: \(post.title())")
}
