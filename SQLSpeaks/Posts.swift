//
//  Contacts.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class Posts
{
    let database: SQLiteDatabase
    
    init(database: SQLiteDatabase) {
        self.database = database
    }
    
    //implement Sequence protocol
    //func next() -> Post {
    //}
    
    func add(title: String) throws -> Post {
        let insertSql = "INSERT INTO Posts (Name) VALUES (?);"
        let insertStatement = try db.prepareStatement(sql: insertSql)
        defer { sqlite3_finalize(insertStatement) } //TODO: Can i just make this last?
        
        //TODO: Find a way to print code
//        let code =  sqlite3_bind_text(insertStatement, 1, title, -1, nil)
//        print("sqlite3_bind_text response code: \(code)")
        guard sqlite3_bind_text(insertStatement, 1, title, -1, nil) == SQLITE_OK else {
            throw SQLiteError.Bind(message: "sqlite3_bind_text")
        }
        
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: "sqlite3_step")
        }
        
        print("Successfully inserted row.")
        
        //TODO: Get id number and return it
        return Post(id: 7, db: database) //TODO: Get the correct id
    }
}
