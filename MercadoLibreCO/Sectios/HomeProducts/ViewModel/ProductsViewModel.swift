//
//  ProductsViewModel.swift
//  MercadoLibreCO
//
//  Created by Juan Diego Marin on 5/11/22.
//

import Foundation

class ProductsViewModel {
    
    // MARK: - Internal Properties
    var error: (String) -> Void = { _ in}
    var success: () -> Void = {}
    var products: [ResultProducts] = []
    
    // MARK: - Private Properties
    
    private var repository: ProductsRepositoryProtocol!
    
    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProduct() {
        repository.getProducts { result in
            switch result {
            case .success(let products):
                self.products = products
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }
}
