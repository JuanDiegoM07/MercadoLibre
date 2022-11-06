//
//  MercadoLibreFake.swift
//  MercadoLibreCOTests
//
//  Created by Juan Diego Marin on 6/11/22.
//

import Foundation
@testable import MercadoLibreCO

enum MercadoLibreFake {
    
    static var values: [Product] {
        [.init(query: "",
               results: resultProducts)]
        
    }
    
    static var resultProducts: [ResultProducts] {
        [.init(title: "",
               price: 0,
               thumbnail: "")]
    }
}

