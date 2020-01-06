//
//  Contact.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class Post
{
    let id: Int
    let db: SQLiteDatabase
    
    init(id: Int, db: SQLiteDatabase) {
        self.id = id
        self.db = db
    }
    
    func title() -> String {
        let titleSql = "SELECT name FROM Posts WHERE id = ?"
        let queryStatement = try! db.prepareStatement(sql: titleSql) //TODO: Remove Bang!
        defer { sqlite3_finalize(queryStatement) }
        
        guard sqlite3_bind_int(queryStatement, 1, Int32(id)) == SQLITE_OK else {
            return "Fuck" //TODO: This is WRong
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return "Shit" //TODO: This is WRong
        }
        
        let queryResultCol1 = sqlite3_column_text(queryStatement, 0)
        let title = String(cString: queryResultCol1!)
        return title
    }
}
