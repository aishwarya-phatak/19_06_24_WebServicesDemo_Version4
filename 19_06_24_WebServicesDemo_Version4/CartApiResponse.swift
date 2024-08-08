//
//  CartApiResponse.swift
//  19_06_24_WebServicesDemo_Version4
//
//  Created by Vishal Jagtap on 08/08/24.
//

import Foundation

//way 2 - of creating Model class for nested json Response
struct CartApiResponse : Decodable{
    var carts : [Cart]
}

struct Cart : Decodable{
    var id : Int
    var userId : Int
    var date : String
    var products : [Product]
    
}

struct Product : Decodable{
    var productId : Int
    var quantity : Int
}
