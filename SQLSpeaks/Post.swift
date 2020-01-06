//
//  Contact.swift
//  SQLSpeaks
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import Foundation

protocol SQLTable {
  static var createStatement: String { get }
}

struct Post
{
  let id: Int32
  let name: NSString
}

extension Post: SQLTable
{
  static var createStatement: String {
    return """
    CREATE TABLE Contact(
      Id INT PRIMARY KEY NOT NULL,
      Name CHAR(255)
    );
    """
  }
}
