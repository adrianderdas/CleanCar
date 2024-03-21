//
//  CzysteAutoTests.swift
//  CzysteAutoTests
//
//  Created by Adrian Derdaś on 02/07/2023.
//

import XCTest
@testable import Czyste_Auto


final class CzysteAutoTests: XCTestCase {
    
    var sut: CartViewModel!
    
    var selectedServices: [DownloadedService] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CartViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testTotalPriceForSelectedServices() {
        let placeholderURL = URL(string: "https://example.com/image.jpg")!
        // given
        let testService1 = DownloadedService(id: 1, title: "Test1", price: 61.12, description: "opis1", imageURL: placeholderURL)
        let testService2 = DownloadedService(id: 1, title: "Test1", price: 100.88, description: "opis2", imageURL: placeholderURL)
        let testService3 = DownloadedService(id: 3, title: "Test3", price: 133.51, description: "opis3", imageURL: placeholderURL)

        // when
        selectedServices = [testService1, testService2, testService3]

        // then
        XCTAssertEqual(sut.calculateTotalPrice(selectedServices), 295.51)

    }

}
