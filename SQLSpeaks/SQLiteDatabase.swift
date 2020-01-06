//
//  Database.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteDatabase
{
    fileprivate var dbPointer: OpaquePointer?
    
    //TODO: Remove this
    var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
    
    //TODO: Make Path Relative
    convenience init() {
        self.init(path: "/Users/DarkKnight/Desktop/SQLSpeaks/SQLSpeaks/db.sqlite")
    }

    init(path: String) {
        guard sqlite3_open(path, &dbPointer) == SQLITE_OK else { fatalError() }
    }
    
    deinit { sqlite3_close(dbPointer) }

    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        return statement
    }
    
    func createTable(sql: String) throws {
        let createTableStatement = try prepareStatement(sql: sql)
        defer { sqlite3_finalize(createTableStatement) }
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("table created")
    }
}


