//
//  MercadoLibreCOViewModelTests.swift
//  MercadoLibreCOTests
//
//  Created by Juan Diego Marin on 5/11/22.
//

import XCTest
@testable import MercadoLibreCO

class MercadoLibreCOViewModelTests: XCTestCase {

    
    // MARK: - Private Properties
    private var requestExpectation: XCTestExpectation?
    // MARK: - Subject under test
    private var viewModel: ProductsViewModel!
    // MARK: - Mock
    private var repositoryMock: MercadolibreRepositoryMock!
    
    
    override func setUp() {
        super.setUp()
        repositoryMock = MercadolibreRepositoryMock()
        viewModel = ProductsViewModel(repository: repositoryMock)
    }

    override func tearDown() {
        super.tearDown()
        repositoryMock = nil
        viewModel = nil
    }
    
    // MARK Tests getProducts
    
    func testGetProducts() {
        // Given
        repositoryMock.products = MercadoLibreFake.resultProducts
        // When
        getProducts()
        // Then
        XCTAssertEqual(requestExpectation?.expectationDescription, ResponseExpectation.ok.rawValue)
    }


}


private extension MercadoLibreCOViewModelTests {
    
    func getProducts() {
        requestExpectation = expectation(description: ResponseExpectation.go.rawValue)
        viewModel.success = {
            self.requestExpectation?.expectationDescription = ResponseExpectation.ok.rawValue
            self.requestExpectation?.fulfill()
        }
        viewModel.getProduct()
        if let requestExpectation = requestExpectation {
            wait(for: [requestExpectation], timeout: 1)
        }
    }
}
