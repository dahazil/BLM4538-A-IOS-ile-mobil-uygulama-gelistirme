//
//  AppViewModel.swift
//  CryptoApp (iOS)
//
//  Created by Balaji on 10/04/22.
//

import SwiftUI
import Combine

struct mywalletModel : Identifiable {
    var id : String
    var name : String
    var symbol: String
    var image : String
    var currentPrice : Double
    var coinPiece : Double
}

class AppViewModel: ObservableObject {
    @Published var coins: [CryptoModel]?
    @Published var highetsPrice = [CryptoModel]()
    @Published var lowestPrice = [CryptoModel]()
    @Published var currentCoin: CryptoModel?
    @Published var currentCoinName = "Bitcoin"
    @Published var chosenCoin : CryptoModel?
    @Published var walletCoin = [CryptoModel]()
    
    @Published var myWalletCoin = [mywalletModel]()
    
    @ObservedObject var vm = kullaniciModeliniAlma()
    
    @Published var walletCoinNameArray : [String] = []
    
    @Published var allsearchCoinArray : [String] = []
    
    @Published var netDegerUsdt : Double = 0.0
    @Published var netDegerBtc : Double = 0.0
    
    
    var temp : Double = 0.0
    var tempName : String = ""
    var maxCoin : CryptoModel!
    var maxPrice : Double = 2000.0
    
    let denex : String = "7d"
    
    
    init(){
        Task{
            do{
                try await fetchCryptoData()
                try await oneCoinDetail()
                try await riseAndDecreasingCoinListed()
            }catch{
                // HANDLE ERROR
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    // MARK: Fetching Crypto Data
    func fetchCryptoData()async throws{
        // MARK: Using Latest Async/Await
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=\(self.denex)") else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: response.0)
        
        // Alternative For DispatchQueue Main
        await MainActor.run(body: {
            self.coins = jsonData
            if let firstCoin = jsonData.first{
                self.currentCoin = firstCoin
            }
            coins?.forEach({ CryptoModel in
                if CryptoModel.name == currentCoinName{
                    self.chosenCoin = CryptoModel
                }
                allsearchCoinArray.append(CryptoModel.name)
            })
        })
    }
    // MARK: Fetching Crypto Data
    func riseAndDecreasingCoinListed()async throws{
        // MARK: Using Latest Async/Await
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=7d") else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: response.0)
        
        // Alternative For DispatchQueue Main
        await MainActor.run(body: {
            self.coins = jsonData
            if let firstCoin = jsonData.first{
                self.currentCoin = firstCoin
            }
            highetsPrice = coins!.sorted(by: { x, y in
                x.price_change > y.price_change
            })
            
            lowestPrice = coins!.sorted(by: { x, y in
                x.price_change < y.price_change
            })
        })
    }

    
    func oneCoinDetail () async throws{
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=7d") else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: response.0)
        
        // Alternative For DispatchQueue Main
        await MainActor.run(body: {
            self.coins = jsonData
            if let firstCoin = jsonData.first{
                self.currentCoin = firstCoin
            }
            coins?.forEach({ CryptoModel in
                vm.items.forEach { tag in
                    if CryptoModel.name == tag.coinName{
                        self.chosenCoin = CryptoModel
                        walletCoinNameArray.append(CryptoModel.name)
                        walletCoin.append(CryptoModel)
                        if tag.coinPiece != 0 {
                            self.myWalletCoin.append(mywalletModel(id: CryptoModel.id, name: CryptoModel.name, symbol: CryptoModel.symbol, image: CryptoModel.image, currentPrice: CryptoModel.current_price, coinPiece: tag.coinPiece))
                        } 
                    }
                }
            })
            
            coins?.forEach({ CryptoModel in
                vm.items.forEach { tag in
                    if CryptoModel.name == tag.coinName && tag.coinPiece != 0 {
                        self.netDegerUsdt = (tag.coinPiece * CryptoModel.current_price) + (self.netDegerUsdt)
                    }
                    if tag.coinName == "USDT" {
                        self.netDegerUsdt = self.netDegerUsdt + tag.coinPiece
                    }
                }
            })
            self.netDegerBtc = self.netDegerUsdt / (currentCoin?.current_price ?? 0.0)
            
            coins?.forEach({ CryptoModel in
                if CryptoModel.name == self.currentCoinName{
                    self.chosenCoin = CryptoModel
                }
            })
        })
    }
    
    func updateWalletCoinBuySell(){
        self.netDegerBtc = 0.0
        self.netDegerUsdt = 0.0
        vm.listenDocument()
        myWalletCoin.removeAll()
        coins?.forEach({ CryptoModel in
            vm.items.forEach { tag in
                if CryptoModel.name == tag.coinName{
                    self.chosenCoin = CryptoModel
                    walletCoinNameArray.append(CryptoModel.name)
                    walletCoin.append(CryptoModel)
                    if tag.coinPiece != 0 {
                        self.myWalletCoin.append(mywalletModel(id: CryptoModel.id, name: CryptoModel.name, symbol: CryptoModel.symbol, image: CryptoModel.image, currentPrice: CryptoModel.current_price, coinPiece: tag.coinPiece))
                    }
                }
            }
        })
        
        coins?.forEach({ CryptoModel in
            vm.items.forEach { tag in
                if CryptoModel.name == tag.coinName && tag.coinPiece != 0 {
                    self.netDegerUsdt = (tag.coinPiece * CryptoModel.current_price) + (self.netDegerUsdt)
                }
                if tag.coinName == "USDT" {
                    self.netDegerUsdt = self.netDegerUsdt + tag.coinPiece
                }
            }
        })
        self.netDegerBtc = self.netDegerUsdt / (currentCoin?.current_price ?? 0.0)
    }
}

