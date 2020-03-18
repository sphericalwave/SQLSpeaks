//
//  Governers.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-03-18.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class Governers
{
    private let database: SQLiteDatabase
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)  //FIXME: Why do i need this to work?

    init(database: SQLiteDatabase) {
        self.database = database
        let constructGovernersTable = """
        CREATE TABLE Governers(
            GID number(6) PRIMARY KEY,
            Name varchar2(25),
            Address varchar2(30),
            TermBegin date,
            TermEnd date
        );
        """
        do { try database.createTable(sql: constructGovernersTable) }
        catch { print(database.errorMessage) }
    }
    
    func add(id: Int, name: String, address: String, termBegin: String) throws {
        //let addGoverner = "INSERT INTO Governers(GID, Name, Address, TermBegin) values(110, 'Bob', '123 Any St', '1-Jan-2009');"
        let addGoverner = "INSERT INTO Governers(GID, Name, Address, TermBegin) values(?, ?, ?, ?);"
        let insertStatement = try db.prepareStatement(sql: addGoverner)
        defer { sqlite3_finalize(insertStatement) } //TODO: Can i just make this last?
        guard sqlite3_bind_int(insertStatement, 1, Int32(id)) == SQLITE_OK else {
            throw SQLiteError.Bind(message: "sqlite3_bind_int")
        }
        guard sqlite3_bind_text(insertStatement, 2, name, -1, SQLITE_TRANSIENT) == SQLITE_OK else {
            throw SQLiteError.Bind(message: "sqlite3_bind_text")
        }
        guard sqlite3_bind_text(insertStatement, 3, address, -1, SQLITE_TRANSIENT) == SQLITE_OK else {
            throw SQLiteError.Bind(message: "sqlite3_bind_text")
        }
        guard sqlite3_bind_text(insertStatement, 4, termBegin, -1, SQLITE_TRANSIENT) == SQLITE_OK else {
            throw SQLiteError.Bind(message: "sqlite3_bind_text")
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: "sqlite3_step")
        }
    }
    
//    func add(title: String) throws -> Post {
//        let insertSql = "INSERT INTO Posts (Name) VALUES (?);"
//        let insertStatement = try db.prepareStatement(sql: insertSql)
//        defer { sqlite3_finalize(insertStatement) } //TODO: Can i just make this last?
//        guard sqlite3_bind_text(insertStatement, 1, title, -1, nil) == SQLITE_OK else {
//            throw SQLiteError.Bind(message: "sqlite3_bind_text")
//        }
//        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
//            throw SQLiteError.Step(message: "sqlite3_step")
//        }
//        print("Successfully inserted Post.")
//        let id = postId(title: title)
//        return Post(id: id, db: database)
//    }
}
