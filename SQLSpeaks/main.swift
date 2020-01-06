//
//  main.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

let db: SQLiteDatabase!
do {
  db = try SQLiteDatabase.open(path: ".")
  print("Successfully opened connection to database.")
} catch SQLiteError.OpenDatabase(let message) {
  print("Unable to open database. Verify that you created the directory described in the Getting Started section.")
}

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

let first = db.contact(id: 1)
print("\(first?.id) \(first?.name)")

