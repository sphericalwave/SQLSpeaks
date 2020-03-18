//
//  State.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-03-18.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation
import SQLite3

class State
{
    private let database: SQLiteDatabase

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
}
