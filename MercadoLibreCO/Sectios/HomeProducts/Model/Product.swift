//
//  Product.swift
//  MercadoLibreCO
//
//  Created by Juan Diego Marin on 5/11/22.
//

import Foundation

struct Product: Decodable {
    let query: String?
    let results: [ResultProducts]?
    
    init(query: String?, results: [ResultProducts]?) {
        self.query = query
        self.results = results
        
    }
}

struct ResultProducts: Decodable {
    let title: String?
    let price: Int?
    let thumbnail: String?
    
    init(title: String?, price: Int?, thumbnail: String?) {
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
}
