//
//  SearchBarView.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 8.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct SearchBarView: View {
    @State var coiName : String = "Bitcoin"
    @ObservedObject var appModel : AppViewModel = AppViewModel()
    @ObservedObject var viewModel : kullaniciModeliniAlma = kullaniciModeliniAlma()
    @State var searchText = ""
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topLeading) {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    if let coins = appModel.coins {
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
                                ForEach(searchResults){ coin in
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
            }.searchable(text: $searchText)
                .navigationBarTitle("Search Coin")
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

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .preferredColorScheme(.dark)
    }
}
