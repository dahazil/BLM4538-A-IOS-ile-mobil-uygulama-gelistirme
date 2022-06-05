//
//  PopulerCoinView.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 18.04.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopulerCoinView: View {
    
    let favoriCoinName : [String : String] = ["btc":"Bitcoin", "eth":"Ethereum", "bnb":"BNB"]
    @StateObject var appModel: AppViewModel = AppViewModel()

    var body: some View {
        HStack{
            if let coins = appModel.coins,let coin = appModel.currentCoin{
                CustomControl(coins: coins)
                
            }
        }
    }
    @ViewBuilder
    func CustomControl(coins: [CryptoModel])->some View{
        HStack(spacing: 50){
            ForEach(coins){coin in
                if favoriCoinName[coin.symbol] == coin.name{
                    VStack(alignment: .leading, spacing: 10){
                        HStack(){
                            /* AnimatedImage(url: URL(string: coin.image))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40) */
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Button {
                                    
                                } label: {
                                    NavigationLink(destination: OneCoinGraph(currentCoin: coin.name)) {
                                        Text("\(coin.name)")
                                            .font(.callout)
                                            .foregroundColor(Color.white)
                                    }
                                }
                                HStack{
                                    Text("\(coin.symbol.uppercased())")
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                        //.foregroundColor(Color("DahaBuyuk"))
                                    Text("\(coin.price_change > 0 ? "+" : "")\(String(format: "%.2f", coin.price_change))")
                                        .foregroundColor(coin.price_change > 0 ? .green : .red)
                                        .font(.caption)
                                }
                                
                            }
                            
                        }
                        Text("\(coin.current_price, specifier: "%.2f")")
                            .bold()
                            .foregroundColor(coin.price_change > 0 ? .green : .red)
                            //.foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

struct PopulerCoinView_Previews: PreviewProvider {
    static var previews: some View {
        PopulerCoinView()
            .preferredColorScheme(.dark)
    }
}
