//
//  CartTableViewCell.swift
//  19_06_24_WebServicesDemo_Version4
//
//  Created by Vishal Jagtap on 08/08/24.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cartIdLabel: UILabel!
    @IBOutlet weak var cartDateLabel: UILabel!
    @IBOutlet weak var cartCollectionView: UICollectionView!
    var dummyArray : [Cart] = []
    var countOfProducts : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initlializeViews()
        registerXIBWithCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func initlializeViews(){
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
    }
    
    private func registerXIBWithCollectionView(){
        let uiNib = UINib(nibName: Constants.reuseIdentifierForCollectionViewCell, bundle: nil)
        
        self.cartCollectionView.register(uiNib, forCellWithReuseIdentifier: Constants.reuseIdentifierForCollectionViewCell)
    }
    
}

extension CartTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for eachCart in dummyArray{
            countOfProducts = eachCart.products.count
        }
        return countOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCollectionViewCell = self.cartCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifierForCollectionViewCell, for: indexPath) as! ProductCollectionViewCollectionViewCell
        for eachCart in dummyArray{
            productCollectionViewCell.productIdLabel.text = String(eachCart.products[indexPath.item].productId)
            productCollectionViewCell.productQuantityLabel.text = String(eachCart.products[indexPath.item].quantity)
        }
       
        return productCollectionViewCell
    }
}


extension CartTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.cartCollectionView.frame.width
        let collectionViewHeight = self.cartCollectionView.frame.height
        
        return CGSize(width: (collectionViewWidth/3.0), height: (collectionViewHeight - 20.0))
    }
}

extension CartTableViewCell : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
