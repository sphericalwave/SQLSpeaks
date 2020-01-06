//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db = SQLiteDatabase()

do {
  try db.createTable(table: Contact.self)
} catch {
  print(db.errorMessage)
}

do {
  try db.insertContact(contact: Contact(id: 1, name: "Ray"))
} catch {
  print(db.errorMessage)
}

if let aContact = db.contact(id: 1) {
    print("\(aContact.id) \(aContact.name)")
}

