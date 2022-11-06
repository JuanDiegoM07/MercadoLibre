//
//  ProductCollectionViewCell.swift
//  MercadoLibreCO
//
//  Created by Juan Diego Marin on 5/11/22.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    
    
    var products: ResultProducts? {
        didSet {
            setup()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setup() {
        nameProductLabel.text = products?.title
        priceProductLabel.text = String(products?.price ?? 00) 
        
        if let url = products?.thumbnail {
            productImage.downloaded(from: url, placeHolder: nil)
        }
    }

}
