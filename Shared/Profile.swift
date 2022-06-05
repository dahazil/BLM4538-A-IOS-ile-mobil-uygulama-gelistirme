//
//  Profile.swift
//  MyCyrpto (iOS)
//
//  Created by Seyfettin Kılınç on 16.04.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase


struct Profile: View {
    @State var currentCoin: String = "btc"
    @State var favoriCoinlerimBtn = true
    @State var cuzdanim = false
    @State var bilgilerim = false
    let favoriCoinName : [String : String] = ["btc":"Bitcoin", "eth":"Ethereum", "bnb":"BNB"]
    @State var favCoinBtc: String = "Bitcoin"
    @State var favCoinEth: String = "Ethereum"
    @State var favCoinBnb: String = "BNB"
    @State var dene = "merhaba"
    @State var coinPriceCurrent : Double = 0.0
    @State var toplamVarlik : Double = 0.0
    @State var temp : Double = 0.0
    
    @State var selectButton = "Favori Coinlerim"
    var pickerText : [String] = ["Favori Coinlerim", "Cüzdanım"]

    @ObservedObject var viewModel = kullaniciModeliniAlma()
    @StateObject var appModel: AppViewModel = AppViewModel()

    var body: some View {
        NavigationView{
            VStack{
                if selectButton == "Favori Coinlerim" {
                    if let coins = appModel.coins,let coin = appModel.currentCoin{
                        CustomControl(coins: coins, favCoin: viewModel.coinFav)
                            .padding()
                    }
                }
                Spacer()
            }.navigationTitle("Favori Coinlerim")
                .onAppear{
                    self.viewModel.veriYakalama()
                }
        }
        
    }
    @ViewBuilder
    func CustomWalletCoinControl(coins: [CryptoModel], walletCoin : String)->some View{
        VStack{
            ForEach(coins){coin in
                if walletCoin == coin.name{
                    HStack(){
                        AnimatedImage(url: URL(string: coin.image))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Button {
                                
                            } label: {
                                NavigationLink(destination: OneCoinGraph(currentCoin: coin.name)) {
                                    Text(coin.name)
                                        .font(.callout)
                                        .foregroundColor(Color.white)
                                }
                            }
                            Text(coin.symbol.uppercased())
                                .font(.caption)
                                .foregroundColor(Color.gray)
                                //.foregroundColor(Color("DahaBuyuk"))
                        }
                        //intCevir(price: coin.current_price)
                    }.padding()
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomControl(coins: [CryptoModel], favCoin : [String])->some View{
        ScrollView{
            VStack(spacing: 15){
                ForEach(coins){coin in
                    ForEach(favCoin, id: \.self){ tag in
                        if tag == coin.name{
                            HStack(spacing: 20){
                                HStack(){
                                    AnimatedImage(url: URL(string: coin.image))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Button {
                                            
                                        } label: {
                                            NavigationLink(destination: OneCoinGraph(currentCoin: coin.name)) {
                                                Text(coin.name)
                                                    .font(.callout)
                                                    .foregroundColor(Color.white)
                                            }
                                        }
                                        Text(coin.symbol.uppercased())
                                            .font(.caption)
                                            .foregroundColor(Color.gray)
                                            //.foregroundColor(Color("DahaBuyuk"))
                                    }
                                }
                                
                                Spacer()
                                
                                Text("\("$")\(coin.current_price, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(coin.price_change > 0 ? .green : .red)
                                    //.foregroundColor(Color.white)
                                    
                                                        
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("AltBaslik"))
                                    
                                    Text("\(coin.price_change > 0 ? "+" : "")\(String(format: "%.2f", coin.price_change))")
                                        .foregroundColor(coin.price_change > 0 ? .green : .red)
                                        .bold()
                                        .background(Color("AltBaslik"))
                                }.frame(width: 50, height: 40)
                                    
                            }
                        }
                    }
                    
                    if currentCoin == coin.symbol{
                        
                    }
                }
            }
        }

    }
    
    @ViewBuilder
    func KullaniciBilgileriDeneme(coins: [CryptoModel], favCoin : [String])->some View{
        VStack{
            ForEach(coins){coin in
                ForEach(viewModel.items){ tag in
                    HStack{
                        if tag.coinName == coin.name && tag.coinPiece != 0{
                            HStack(){
                                AnimatedImage(url: URL(string: coin.image))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Button {
                                        
                                    } label: {
                                        NavigationLink(destination: OneCoinGraph(currentCoin: coin.name)) {
                                            Text(coin.name)
                                                .font(.callout)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    Text(coin.symbol.uppercased())
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                        //.foregroundColor(Color("DahaBuyuk"))
                                }
                            }.padding()
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 5){
                                Text("\("$")\(tag.coinPiece * coin.current_price, specifier: "%.2f")")
                                Text("\(tag.coinPiece, specifier: "%.3f")")
                                    .font(.caption)
                            }
                        }
                    }
                        
                }
                if currentCoin == coin.symbol{
                    
                }
            }
        }.onAppear{
            viewModel.listenDocument()
        }
    }
    func intCevir(price : String){
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        coinPriceCurrent = nf.number(from: price)?.doubleValue ?? 0.0
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .preferredColorScheme(.dark)
    }
}
