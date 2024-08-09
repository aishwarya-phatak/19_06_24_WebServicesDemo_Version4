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
        return Constants.carts[collectionView.tag].products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCollectionViewCell = self.cartCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifierForCollectionViewCell, for: indexPath) as! ProductCollectionViewCollectionViewCell
        
        productCollectionViewCell.layer.backgroundColor = CGColor(red: 0.0, green: 0.0, blue: 100.0, alpha: 0.3)
        productCollectionViewCell.layer.borderColor = CGColor(red: 50.0, green: 0.0, blue: 0.0, alpha: 0.5)
        productCollectionViewCell.layer.borderWidth = 6.0
        productCollectionViewCell.layer.cornerRadius = 10.0
        
        
        productCollectionViewCell.productIdLabel.text = String(Constants.carts[collectionView.tag].products[indexPath.item].productId)
        productCollectionViewCell.productQuantityLabel.text = String(Constants.carts[collectionView.tag].products[indexPath.item].quantity)
        
        return productCollectionViewCell
    }
}

extension CartTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.cartCollectionView.frame.width
        let collectionViewHeight = self.cartCollectionView.frame.height
        
        return CGSize(width: (collectionViewWidth/3.0), height: (collectionViewHeight-5.0))
    }
}

extension CartTableViewCell : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
