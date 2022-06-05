//
//  AllCoinList.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 18.04.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct AllCoinList: View {
    @State var temp : Double = 0.06
    @State var tumCoinler : Bool = true
    @State var selectText : String = "All Coins"
    @State var priceRisers : Bool = false
    
    @State var searchText = ""
    var pickerText : [String] = ["All Coins", "Rising Price", "Decreasing Price"]
    
    @StateObject var appModel: AppViewModel = AppViewModel()
    
    var body: some View {
        VStack{
            
            Picker("Select text", selection: $selectText){
                ForEach(self.pickerText, id : \.self){
                    Text($0).tag($0)
                }
                
            }.pickerStyle(SegmentedPickerStyle())
            if selectText == "All Coins"{
                if let coins = appModel.coins{
                    CustomControl(coins: coins)
                }
            }
            else if selectText == "Rising Price"{
                if let coins = appModel.highetsPrice{
                    CustomControlPriceRisers(coins: coins)
                }
            }
            
            else if selectText == "Decreasing Price"{
                if let coins = appModel.lowestPrice{
                    CustomControlPriceDecreasing(coins: coins)
                }
            }
        }
    }
    @ViewBuilder
    func CustomControl(coins: [CryptoModel])->some View{
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 25){
                HStack{
                    
                    Text("Coin")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading,10)
                    Spacer()
                    Text("Price")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.trailing,10)
                }
                ForEach(coins){coin in
                    VStack(alignment: .leading, spacing: 10){
                        HStack(){
                            AnimatedImage(url: URL(string: coin.image))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                            
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
                            Spacer()
                            Text("\("$")\(coin.current_price, specifier: "%.2f")")
                                .bold()
                                .foregroundColor(coin.price_change > 0 ? .green : .red)
                                //.foregroundColor(Color.white)
                        }
                    }
                }
                
            }
            
        }
    }
    
    
    @ViewBuilder
    func CustomControlPriceRisers(coins : [CryptoModel]) -> some View {
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 25){
                HStack{
                    Text("Coin")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading,10)
                    Spacer()
                    Text("Price")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.trailing,10)
                }
                
                ForEach(coins){coin in
                    if coin.price_change > 0 {
                        VStack(alignment: .leading, spacing: 10){
                            HStack(){
                                AnimatedImage(url: URL(string: coin.image))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                
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
                                Spacer()
                                Text("\("$")\(coin.current_price, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(coin.price_change > 0 ? .green : .red)
                                    //.foregroundColor(Color.white)
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
    @ViewBuilder
    func CustomControlPriceDecreasing(coins : [CryptoModel]) -> some View {
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 25){
                HStack{
                    Text("Coin")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading,10)
                    Spacer()
                    Text("Price")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.trailing,10)
                }
                
                ForEach(coins){coin in
                    if coin.price_change < 0 {
                        VStack(alignment: .leading, spacing: 10){
                            HStack(){
                                AnimatedImage(url: URL(string: coin.image))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                
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
                                Spacer()
                                Text("\("$")\(coin.current_price, specifier: "%.2f")")
                                    .bold()
                                    .foregroundColor(coin.price_change > 0 ? .green : .red)
                                    //.foregroundColor(Color.white)
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
    
    var searchResults : [CryptoModel] {
        if searchText.isEmpty{
            return appModel.coins!
        }
        else {
            return appModel.coins!.filter { CryptoModel in
                CryptoModel.name.contains(searchText)
            }
        }
    }
}

struct AllCoinList_Previews: PreviewProvider {
    static var previews: some View {
        AllCoinList()
            .preferredColorScheme(.dark)
    }
}
