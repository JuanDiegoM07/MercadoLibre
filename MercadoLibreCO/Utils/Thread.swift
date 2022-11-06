//
//  Thread.swift
//  MercadoLibreCO
//
//  Created by Juan Diego Marin on 5/11/22.
//

import Foundation

import Foundation

enum Thread {
    static func main(_ block: @escaping () -> Void?) {
        DispatchQueue.main.async {
            block()
        }
    }
}
