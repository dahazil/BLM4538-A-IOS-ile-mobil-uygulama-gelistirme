//
//  CryptoModel.swift
//  CryptoApp (iOS)
//
//  Created by Balaji on 10/04/22.
//

import SwiftUI

// MARK: Crypto Model For JSON Fetching
struct CryptoModel: Identifiable,Codable{
    var id: String
    var symbol: String
    var name: String
    var image: String
    var current_price: Double
    var last_updated: String
    var price_change: Double
    var last_7days_price: GraphModel
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    
    
    
    enum CodingKeys: String,CodingKey{
        case id
        case symbol
        case name
        case image
        case current_price
        case last_updated
        case price_change = "price_change_percentage_24h"
        case last_7days_price = "sparkline_in_7d"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
    }
}

struct GraphModel: Codable{
    var price: [Double]
    enum CodingKeys: String,CodingKey{
        case price
    }
}

// JSON URL
var url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")


