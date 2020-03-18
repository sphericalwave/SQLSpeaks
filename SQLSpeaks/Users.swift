//
//  Users.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-03-18.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class Users
{
    private let database: SQLiteDatabase

    init(database: SQLiteDatabase) {
        self.database = database
        let constructUserTable = """
        CREATE TABLE Users(
            id number(3) PRIMARY KEY,
            name varchar2(15)
        );
        """
        do { try database.createTable(sql: constructUserTable) }
        catch { print(database.errorMessage) }
    }
}
