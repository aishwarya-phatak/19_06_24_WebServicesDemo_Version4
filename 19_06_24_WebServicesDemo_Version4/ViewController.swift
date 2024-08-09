//
//  ViewController.swift
//  19_06_24_WebServicesDemo_Version4
//
//  Created by Vishal Jagtap on 08/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cartsTableView: UITableView!
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var jsonDecoder : JSONDecoder?
//    var carts : [Cart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        registerXIBWithTableView()
        parseJSON()
    }
    
    private func initializeViews(){
        cartsTableView.dataSource = self
        cartsTableView.delegate = self
    }
    
    private func registerXIBWithTableView(){
        let uiNib = UINib(nibName: Constants.reuseIdentifierForTableViewCell, bundle: nil)
        self.cartsTableView.register(uiNib, forCellReuseIdentifier: Constants.reuseIdentifierForTableViewCell)
    }
    
    private func parseJSON(){
        
        url = URL(string: Constants.urlString)
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            
            self.jsonDecoder = JSONDecoder()
            Constants.carts = try! self.jsonDecoder!.decode([Cart].self, from: data!)
            print(Constants.carts)
            
            for eachCart in Constants.carts{
                for eachProduct in eachCart.products{
                    print(eachProduct.productId)
                    print(eachProduct.quantity)
                }
            }
            
            DispatchQueue.main.async {
                self.cartsTableView.reloadData()
            }
        })
        dataTask?.resume()
    }
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.carts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartTableViewCell = self.cartsTableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierForTableViewCell, for: indexPath) as! CartTableViewCell
        cartTableViewCell.cartIdLabel.text = String(Constants.carts[indexPath.row].id)
        cartTableViewCell.cartDateLabel.text = Constants.carts[indexPath.row].date
        cartTableViewCell.cartCollectionView.tag = indexPath.row
        cartTableViewCell.cartCollectionView.reloadData()
        
        return cartTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196.0
    }
}
