//
//  CzysteAutoTests.swift
//  CzysteAutoTests
//
//  Created by Adrian Derdaś on 02/07/2023.
//

import XCTest
@testable import Czyste_Auto


final class CzysteAutoTests: XCTestCase {
    
    var sut: OrdersViewModel!
    
    var selectedServices: [Service] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = OrdersViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testTotalPriceForSelectedServices() {
        // given
        let testService1 = Service(name: "Test1", image: "test_image1", price: 100)
        let testService2 = Service(name: "Test2", image: "test_image2", price: 200)
        let testService3 = Service(name: "Test3", image: "test_image3", price: 300)


        // when
        selectedServices = [testService1, testService2, testService3]

        // then
        XCTAssertEqual(sut.calculateTotalPrice(selectedServices), 600)

    }

}
