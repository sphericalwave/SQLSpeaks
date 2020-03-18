//
//  Supplier.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-09.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

class Supplier
{
    let id: Int
    let name: String
    let supplierGroupId: Int
    private let database: SQLiteDatabase
    
    init(id: Int, name: String, supplierGroupId: Int, database: SQLiteDatabase) {
        self.id = id
        self.name = name
        self.supplierGroupId = supplierGroupId
        self.database = database
    }
    
//    func name() -> String {
//        return "name() -> TODO"
//    }
    
    
}
