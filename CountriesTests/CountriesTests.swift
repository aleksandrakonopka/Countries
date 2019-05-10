//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Aleksandra Konopka on 10/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import XCTest
@testable import Countries

class CountriesTests: XCTestCase {

    var sut : ViewController!
    
    override func setUp() {
        super.setUp()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = (sb.instantiateViewController(withIdentifier: "viewController1") as! ViewController)
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
        DummyCountries.clear()
    }
    
    func testSearchBarIsVisible()
    {
        XCTAssertFalse(sut.searchBar.isHidden)
    }
    
    func testTableViewOneDummy()
    {
        sut.countries = DummyCountries.dummyCountries
        sut.tableView.reloadData()
        XCTAssert(sut.tableView.numberOfRows(inSection: 0) == 1)
        XCTAssert(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel!.text == "Poland")
    }
    func testTableViewTwoDummies()
    {
        DummyCountries.addMoreDummyCountries()
        sut.countries = DummyCountries.dummyCountries
        XCTAssert(sut.tableView.numberOfRows(inSection: 0) == 2)
        XCTAssert(sut.tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel!.text == "Poland2")
    }
}
