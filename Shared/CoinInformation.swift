//
//  CoinInformation.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 25.04.2022.
//

import SwiftUI

struct CoinInformation: View {
    @StateObject var appModel: AppViewModel = AppViewModel()
    @State var coinname = "Bitcoin"

    var body: some View {
        HStack{
            if let coin = appModel.currentCoin {
                VStack(spacing : 12){
                    HStack{
                        Text("Anlık Fiyat: ")
                            .foregroundColor(.gray)
                        Text("\("$")\(coin.current_price, specifier: "%.2f")")
                            .foregroundColor(Color("Renk1"))
                    }
                    HStack{
                        Text("En Yüksek: ")
                            .foregroundColor(.gray)
                        Text("\("$")\(coin.high24H!, specifier: "%.2f")")
                            .foregroundColor(Color("Renk1"))
                    }
                    HStack{
                        Text("En Düşük: ")
                            .foregroundColor(.gray)
                        //Text("\("$")\(coin.currentPrice, specifier: "%.2f")")
                        Text("\("$")\(coin.low24H!, specifier: "%.2f")")
                            .foregroundColor(Color("Renk1"))
                    }
                }.padding(.leading,10)
                    .font(.system(size: 15))
                Spacer()
                VStack{
                    HStack{
                        Text("Total Volume: ")
                             .foregroundColor(.gray)
                         Text("\("$")\(coin.totalVolume!, specifier: "%.2f")")                        .foregroundColor(Color("Renk1"))
                    }
                    HStack{
                        Text("Değişim Miktarı: ")
                            .foregroundColor(.gray)
                        Text("\("$")\(coin.priceChange24H!, specifier: "%.2f")")                        .foregroundColor(Color("Renk1"))

                    }
                    HStack{
                        Text("Son Güncelleme")
                            .foregroundColor(.gray)
                        Text(coin.last_updated)
                            .foregroundColor(Color("Renk1"))
                    }
                }.font(.system(size: 15))
            }
        }.onAppear{
            self.currentCoinName()
        }
    }
    
    func currentCoinName () {
        appModel.currentCoinName = self.coinname
    }
}

struct CoinInformation_Previews: PreviewProvider {
    static var previews: some View {
        CoinInformation()
            .preferredColorScheme(.dark)
    }
}
