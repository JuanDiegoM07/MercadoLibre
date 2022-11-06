//
//  ViewController.swift
//  MercadoLibreCO
//
//  Created by Juan Diego Marin on 5/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    // Private Properties
    
    private var viewModel = ProductsViewModel(repository: ProductRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.register(.init(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        viewModel.getProduct()
        viewModel.success = {
            self.productCollectionView.reloadData()
        }
        viewModel.error = {error in
            print(error)
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.products = viewModel.products[indexPath.row]
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((UIScreen.main.bounds.width) / 2), height: CGFloat((view.bounds.height - 200) / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
}
