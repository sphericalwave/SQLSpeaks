//
//  Contacts.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

struct Posts: Sequence, IteratorProtocol
{
    typealias Element = Post
    var index: Int = 1 //SQL indexes start at 1...TODO: violating the mutability principle
    private let database: SQLiteDatabase
    
    init(database: SQLiteDatabase) {
        self.database = database
    }
    
    //implement Sequence protocol
    mutating func next() -> Post? {
        guard index <= count() else {
            index = 1 //TODO: Violating the Mutability Principle
            return nil
        }
        let post = Post(id: index, db: database)
        index += 1
        return post
    }
    
    //TODO: Increase Efficiency don't want to hit the database repeatedly
    //Appears to Work
    //TODO: Fix Naming
    func count() -> Int {
        let idSql = "SELECT COUNT(*) FROM posts"
        let queryStatement = try! db.prepareStatement(sql: idSql) //TODO: Remove Bang!
        defer { sqlite3_finalize(queryStatement) }
        guard sqlite3_step(queryStatement) == SQLITE_ROW else { return 89 } //TODO: This is WRong
        let queryResultCol1 = sqlite3_column_int(queryStatement, 0)
        return Int(queryResultCol1)
    }
    
    func add(title: String) throws -> Post {
        let insertSql = "INSERT INTO Posts (Name) VALUES (?);"
        let insertStatement = try db.prepareStatement(sql: insertSql)
        defer { sqlite3_finalize(insertStatement) } //TODO: Can i just make this last?
        
//        #warning("TODO: Find a way to print code")
////        let code =  sqlite3_bind_text(insertStatement, 1, title, -1, nil)
////        print("sqlite3_bind_text response code: \(code)")
        guard sqlite3_bind_text(insertStatement, 1, title, -1, nil) == SQLITE_OK else {
            throw SQLiteError.Bind(message: "sqlite3_bind_text")
        }
        
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: "sqlite3_step")
        }
        
        print("Successfully inserted Post.")
        
        let id = postId(title: title)
        return Post(id: id, db: database)
    }
    
    func postId(title: String) -> Int {
        let idSql = "SELECT id FROM Posts WHERE name = ?"
        let queryStatement = try! db.prepareStatement(sql: idSql) //TODO: Remove Bang!
        defer { sqlite3_finalize(queryStatement) }
        guard sqlite3_bind_text(queryStatement, 1, title, -1, nil) == SQLITE_OK else { return 77 } //TODO: This is WRong
        guard sqlite3_step(queryStatement) == SQLITE_ROW else { return 89 } //TODO: This is WRong
        let queryResultCol1 = sqlite3_column_int(queryStatement, 0)
        return Int(queryResultCol1)
    }
}
