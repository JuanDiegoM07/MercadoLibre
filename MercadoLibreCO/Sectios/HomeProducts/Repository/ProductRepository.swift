//
//  ProductRepository.swift
//  MercadoLibreCO
//
//  Created by Juan Diego Marin on 5/11/22.
//

import Foundation
import UIKit
import CoreData

protocol ProductsRepositoryProtocol {
    func getProducts(completionHandler: @escaping (Result<[ResultProducts], Error>) -> Void)
}

class ProductRepository: ProductsRepositoryProtocol {
    
    func getProducts(completionHandler: @escaping (Result<[ResultProducts], Error>) -> Void) {
        let localProduct = self.getProducts()
        if localProduct.results?.count ?? 0 > 0{
            completionHandler(.success(localProduct.results ?? []))
        }
        let url = URL(string: "https://api.mercadolibre.com/sites/MCO/search?q=iphone")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error ) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                do {
                    let products = try JSONDecoder().decode(Product.self, from: data)
                         DispatchQueue.main.async {
                             self.deleteAllProducts()
                             self.saveProduct(products)
                             completionHandler(.success(products.results ?? []))
                         }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Error")
            }
        })
        task.resume()
        
    }
    
    func saveProduct(_ products: Product) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let productCoreData = ProductCD(context: appDelegate.persistentContainer.viewContext)
        productCoreData.query = products.query
                
        appDelegate.saveContext()
        
    }
    
    
    private func getProducts() -> Product {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .init(query: "", results: [])
        }
        var product: Product = .init(query: "", results: [])
        do {
            let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
            let coreDataProducts = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            coreDataProducts.forEach {
                product = Product(query: $0.query, results: [])
            }
        } catch {
            print(error.localizedDescription)
        }
        return product
    }
    
    private func deleteAllProducts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        do {
            let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
            let coreDataProducts = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            coreDataProducts.forEach {
                appDelegate.persistentContainer.viewContext.delete($0)
            }
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
