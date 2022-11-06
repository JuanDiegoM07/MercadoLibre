//
//  MercadolibreRepositoryMock.swift
//  MercadoLibreCOTests
//
//  Created by Juan Diego Marin on 6/11/22.
//

import Foundation
@testable import MercadoLibreCO

class MercadolibreRepositoryMock: ProductsRepositoryProtocol {
    var products: [ResultProducts]?
    
    
    func getProducts(completionHandler: @escaping (Result<[ResultProducts], Error>) -> Void) {
        if let products = products {
            completionHandler(.success(products))
        }
    }
    
}
