//
//  SQLSpeaksTests.swift
//  SQLSpeaksTests
//
//  Created by Aaron Anthony on 2020-01-06.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import XCTest


class SQLSpeaksTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
        let db = SQLiteDatabase()
        XCTAssertNotNil(db)
    }
}
