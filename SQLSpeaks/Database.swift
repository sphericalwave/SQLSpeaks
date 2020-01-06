//
//  Database.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteDatabase {
    fileprivate var dbPointer: OpaquePointer?
    
    convenience init() {
        self.init(path: "./db.sqlite3")
    }

    init(path: String) {
        //self.dbPointer = nil
        guard sqlite3_open(path, &dbPointer) == SQLITE_OK else { fatalError() }
    }
    
    var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
    
//    private init(dbPointer: OpaquePointer?) {
//        self.dbPointer = dbPointer
//    }
    
    deinit {
        sqlite3_close(dbPointer)
    }
    
//    static func open(path: String) throws -> SQLiteDatabase {
//        var db: OpaquePointer? = nil
//        // 1
//        if sqlite3_open(path, &db) == SQLITE_OK {
//            // 2
//            return SQLiteDatabase(dbPointer: db)
//        } else {
//            // 3
//            defer {
//                if db != nil {
//                    sqlite3_close(db)
//                }
//            }
//
//            if let errorPointer = sqlite3_errmsg(db) {
//                let message = String.init(cString: errorPointer)
//                throw SQLiteError.OpenDatabase(message: message)
//            } else {
//                throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
//            }
//        }
//    }
}

extension SQLiteDatabase {
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        
        return statement
    }
}

extension SQLiteDatabase {
    func createTable(table: SQLTable.Type) throws {
        // 1
        let createTableStatement = try prepareStatement(sql: table.createStatement)
        // 2
        defer {
            sqlite3_finalize(createTableStatement)
        }
        // 3
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("\(table) table created.")
    }
}



extension SQLiteDatabase {
    func insertContact(contact: Contact) throws {
        let insertSql = "INSERT INTO Contact (Id, Name) VALUES (?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        let name: NSString = contact.name
        guard sqlite3_bind_int(insertStatement, 1, contact.id) == SQLITE_OK  &&
            sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil) == SQLITE_OK else {
                throw SQLiteError.Bind(message: errorMessage)
        }
        
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        
        print("Successfully inserted row.")
    }
}

extension SQLiteDatabase {
    func contact(id: Int32) -> Contact? {
        let querySql = "SELECT * FROM Contact WHERE Id = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        guard sqlite3_bind_int(queryStatement, 1, id) == SQLITE_OK else {
            return nil
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        
        let id = sqlite3_column_int(queryStatement, 0)
        
        let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
        let name = String(cString: queryResultCol1!) as NSString
        
        return Contact(id: id, name: name)
    }
}
