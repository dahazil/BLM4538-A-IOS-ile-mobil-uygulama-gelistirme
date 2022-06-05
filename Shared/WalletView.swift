//
//  WalletView.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 9.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI



struct WalletView: View {
    
    @ObservedObject var viewModel = kullaniciModeliniAlma()
    @StateObject var appModel: AppViewModel = AppViewModel()
    
    @State var netDeger : Double = 0.0
    var body: some View {
        ScrollView{
            Text("Spot")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 200, height: 50)
                
            HStack{
                VStack{
                    Text("Net Deger(BTC)")
                        .font(.body)
                        .foregroundColor(.gray)
                    Text("\(appModel.netDegerBtc, specifier: "%.2f")")
                        .font(.system(size: 20))
                        .padding(.top,2)
                        .foregroundColor(Color("Renk1"))
                }.padding(.leading,20)
                Spacer()
                VStack{
                    Text("Net Deger(USDT)")
                        .font(.body)
                        .foregroundColor(.gray)
                    Text("\("$")\(appModel.netDegerUsdt,specifier: "%.3f")")
                        .font(.system(size: 20))
                        .padding(.top,2)
                        .foregroundColor(Color("Renk1"))
                        
                }.padding(.leading,20)
            }.padding(.top,20)
            
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Text("Yatırma")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 8)
                        .padding(.vertical)
                        .background{
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color("LightGreen"))
                        }
                }
                
                Button {
                    
                } label: {
                    Text("Çekme")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 8)
                        .padding(.vertical)
                        .background{
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.white)
                        }
                }
                
                Button {
                    
                } label: {
                    Text("Transfer")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 8)
                        .padding(.vertical)
                        .background{
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.white)
                        }
                }
                Spacer()
            }.padding()
            
            VStack(spacing: 7){
                ForEach(appModel.myWalletCoin){ coin in
                    HStack(spacing: 15){
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
                            Text("\("$")\(coin.coinPiece * coin.currentPrice, specifier: "%.2f")")
                            Text("\(coin.coinPiece, specifier: "%.3f")")
                                .font(.caption)
                        }
                    }
                    
                }
            }
            
        }.onAppear{
            appModel.updateWalletCoinBuySell()
        }
    }
    func netDegerHesapla(wallet : [mywalletModel]){
        
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .preferredColorScheme(.dark)
    }
}
