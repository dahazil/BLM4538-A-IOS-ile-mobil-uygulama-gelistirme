//
//  DenemeBuySell.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 3.05.2022.
//

import SwiftUI
import SwiftUI
import SDWebImageSwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct DenemeBuySell: View {
    
       @State var showAlert: Bool = false
       @State var alertType: MyAlerts? = nil
       enum MyAlerts {
           case success
           case error
           case sellSuccess
           case sellError
       }
       
       @Environment(\.presentationMode) var presentationMode

       
       @State var buy = true
       @State var miktarCoin : Double = 0.0
       @State var toplamUsdt : Double = 0.0
       @State var doubleValue : Double = 1.56
       @State var kullanilabilirUsdt : Double = 100.0
       @State var degisimUsdt : Double = 0.0
       @State var degisimCoin : Double = 0.0
       @State var price : String = ""
       @State var degisim = false
       private var db = Firestore.firestore()
       
       @State var showSheet: Bool = false


       
       @State var coinName = "Ethereum"
       @ObservedObject var appModel : AppViewModel = AppViewModel()
       @ObservedObject var viewModel = kullaniciModeliniAlma()
       init(){
           setCoinName()
       }
       var body: some View {
           ScrollView{
               VStack(spacing: 10){
                   /*VStack{
                       Text("\(degisimCoin)")
                           .font(.title)
                       Text("\(degisimUsdt)")
                           .font(.title)
                       Text("\(miktarCoin)")
                           .font(.title)
                       Text("\(toplamUsdt)")
                           .font(.title)
                       Text("\(viewModel.usdtPieces ?? 0.0)")
                           .font(.title)
                       Text("\(viewModel.oneWalletPieces ?? 0.0)")
                           .font(.title)
                   }*/
                   
                   HStack{
                       Button {
                           showSheet.toggle()
                       } label: {
                           Image("icons8-change-48 (1)")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 40, height: 40)
                               .foregroundColor(.white)
                               //.background(Color.gray)
                       }.sheet(isPresented: $showSheet, content: {
                           // DO NOT ADD CONDITIONAL LOGIC
                           SecondScreens(coiName: appModel.chosenCoin?.name ?? " ", appModel: appModel, viewModel: viewModel)
                       })

                       AnimatedImage(url: URL(string: appModel.chosenCoin?.image as? String ?? ""))
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(width: 50, height: 50)
                       Text(appModel.chosenCoin?.name ?? " ") //coin ismi
                           .font(.largeTitle)
                           .foregroundColor(Color.white)
                           .bold()
                   }
                   Text("\("$")\(appModel.chosenCoin?.current_price as? Double ?? 0.0, specifier: "%.2f")")
                       .font(.body)
                       .fontWeight(.black)
                   
                   
                   HStack{
                       Text("\(appModel.chosenCoin?.symbol.uppercased() as? String ?? "")\("/USD")")
                           .font(.title2)
                           .fontWeight(.black)
                       Text("\(appModel.chosenCoin?.price_change ?? 0.0 > 0 ? "+" : "")\(String(format: "%.2f", appModel.chosenCoin?.price_change ?? 0.0))")
                           .foregroundColor(appModel.chosenCoin?.price_change ?? 0.0 > 0 ? .green : .red)
                           .font(.body)
                       Spacer()
                       Picker("Select text", selection: $buy){
                           Text("Buy").tag(true)
                           Text("Sell").tag(false)
                       }.pickerStyle(SegmentedPickerStyle()).frame(width: 150)
                   
                   }.padding()
                   
                   HStack{
                       if let coins = appModel.coins{
                           ForEach(coins){ coin in
                               if coin.name == appModel.chosenCoin?.name ?? " "{
                                   GraphView(coin: coin)
                               }
                           }
                       }
                       Spacer()
                       
                       VStack{
                           VStack(alignment: .leading, spacing:6){
                               Text("Fiyat")
                                   .font(.caption)
                                   .padding(.leading,10)
                               TextField("\(appModel.chosenCoin?.current_price as? Double ?? 0.0, specifier: "%.2f")", text: $price)
                                   .keyboardType(.numberPad)
                                   .background(Color.white.opacity(0.1).cornerRadius(5))
                                   .textFieldStyle(.roundedBorder)
                                   .autocapitalization(.none)
                                   .multilineTextAlignment(.center)
                           }
                           VStack(alignment: .leading, spacing:6){
                               Text("Miktar")
                                   .font(.caption)
                                   .padding(.leading,10)
                               TextField("Miktar \("(\(coinName))"):", value: $miktarCoin, format:.number)
                                   .onChange(of: miktarCoin) {
                                       self.toplamUsdt = self.miktarCoin * (appModel.chosenCoin?.current_price ?? 1)
                                       
                                       print($0) // You can do anything due to the change here.
                                       // self.autocomplete($0) // like this
                                   }
                                   .keyboardType(.numberPad)
                                   .background(Color.white.opacity(0.1).cornerRadius(5))
                                   .textFieldStyle(.roundedBorder)
                                   .autocapitalization(.none)
                                   .multilineTextAlignment(.center)
                           }
                           HStack{
                               Spacer()
                               Button {
                                   self.miktarCoin = (toplamUsdt / appModel.chosenCoin!.current_price as? Double ?? 0.0) / 4
                               } label: {
                                   Text("%25")
                                       .font(.body)
                               }
                               .foregroundColor(Color("Renk1"))
                               Spacer()
                               Button {
                                   self.miktarCoin = (toplamUsdt / appModel.chosenCoin!.current_price as? Double ?? 0.0) / 2
                               } label: {
                                   Text("%50")
                                       .font(.body)
                               }.foregroundColor(Color("Renk1"))
                               Spacer()
                               Button {
                                   self.miktarCoin = (((toplamUsdt / appModel.chosenCoin!.current_price as? Double ?? 0.0) * 3 ) / 4)
                               } label: {
                                   Text("%75")
                                       .font(.body)
                               }.foregroundColor(Color("Renk1"))
                               Spacer()
                               Button {
                                   self.miktarCoin = (toplamUsdt / appModel.chosenCoin!.current_price as? Double ?? 0.0) / 1
                               } label: {
                                   Text("%100")
                                       .font(.body)
                               }.foregroundColor(Color("Renk1"))
                               Spacer()

                           }.padding(.top, 10).padding(.bottom)
                           
                           VStack(alignment: .leading, spacing: 6){
                               Text("Toplam Usdt")
                                   .font(.caption)
                                   .padding(.leading,10)
                               TextField("Toplam $", value: $toplamUsdt, formatter: NumberFormatter())
                                           .onChange(of: toplamUsdt) {
                                               self.miktarCoin = self.toplamUsdt / (appModel.chosenCoin?.current_price ?? 1)
                                               print($0) // You can do anything due to the change here.
                                               // self.autocomplete($0) // like this
                                           }
                                           .keyboardType(.numberPad)
                                           .background(Color.white.opacity(0.1).cornerRadius(5))
                                           .textFieldStyle(.roundedBorder)
                                           .autocapitalization(.none)
                                           .multilineTextAlignment(.center)
                               HStack{
                                   Text("Kullanılabilir: ")
                                       .font(.caption)
                                       .foregroundColor(.gray)
                                       .padding(.leading,10)
                                   Spacer()
                                   Text("\("$")\(viewModel.usdtPieces ?? 0.0,specifier: "%.2f")")
                               }
                           }
                       }.padding(.trailing,10)
                   }
                   
                   if buy == true {
                       HStack{
                           Spacer()
                           Button {
                               if viewModel.usdtPieces >= toplamUsdt {
                                   if viewModel.usdtPieces >= miktarCoin{
                                       viewModel.oneWalletPieces = miktarCoin + viewModel.oneWalletPieces
                                       viewModel.usdtPieces = viewModel.usdtPieces - toplamUsdt
                                       
                                       toplamUsdt = 0
                                       miktarCoin = 0
                                       
                                       alertType = .success
                                       showAlert.toggle()
                                       let washingtonRef = db.collection("AllUsersWallet").document(globalEmail)

                                               // Set the "capital" field of the city 'DC'
                                               washingtonRef.updateData([
                                                   appModel.chosenCoin?.name ?? " ": viewModel.oneWalletPieces,
                                                   "USDT" : viewModel.usdtPieces
                                               ]) { err in
                                                   if let err = err {
                                                       print("Error updating document: \(err)")
                                                   } else {
                                                       print("Document successfully updated")
                                                       
                                                   }
                                               }
                                   }
                               }
                               else if toplamUsdt > viewModel.usdtPieces {
                                   alertType = .error
                                   showAlert.toggle()
                               }
                           } label: {
                               Text("Buy")
                                   .fontWeight(.bold)
                                   .foregroundColor(.black)
                                   .frame(maxWidth: .infinity)
                                   .padding(.vertical)
                                   .background{
                                       RoundedRectangle(cornerRadius: 12, style: .continuous)
                                           .fill(Color("LightGreen"))
                                   }
                           }.alert(isPresented: $showAlert, content: {
                               getAlert()
                           })
                       }.padding(.top, 20)
                           .padding(.leading, 20)
                           .padding(.trailing, 20)
                   }
                   
                   if buy == false {
                       HStack{
                           Spacer()
                           VStack{
                               Button {
                                   if viewModel.oneWalletPieces >= miktarCoin && (miktarCoin != 0){
                                       viewModel.oneWalletPieces = viewModel.oneWalletPieces - miktarCoin
                                       viewModel.usdtPieces = viewModel.usdtPieces + (miktarCoin * (appModel.chosenCoin?.current_price ?? 0.0) )
                                       
                                       toplamUsdt=0
                                       miktarCoin=0
                                       
                                       alertType = .sellSuccess
                                       showAlert.toggle()
                                       let washingtonRef = db.collection("AllUsersWallet").document(globalEmail)
                                               // Set the "capital" field of the city 'DC'
                                               washingtonRef.updateData([
                                                   appModel.chosenCoin?.name ?? " ": viewModel.oneWalletPieces,
                                                   "USDT" : viewModel.usdtPieces
                                               ]) { err in
                                                   if let err = err {
                                                       print("Error updating document: \(err)")
                                                   } else {
                                                       print("Document successfully updated")
                                                   }
                                               }
                                   }
                                   else if viewModel.oneWalletPieces < miktarCoin {
                                       alertType = .sellError
                                       showAlert.toggle()
                                   }
                                   else if miktarCoin == 0 {
                                       alertType = .sellError
                                       showAlert.toggle()
                                   }
                                   
                               } label: {
                                   Text("Sell")
                                       .fontWeight(.bold)
                                       .foregroundColor(.black)
                                       .frame(maxWidth: .infinity)
                                       .padding(.vertical)
                                       .background{
                                           RoundedRectangle(cornerRadius: 12, style: .continuous)
                                               .fill(.pink)
                                       }
                               }.alert(isPresented: $showAlert, content: {
                                   getAlert()
                               })

                           }.padding(.top, 20)
                               .padding(.leading, 20)
                               .padding(.trailing, 20)
                       }
                   }
                   
                   Spacer()
               }.onAppear{
                   //getFirebaseWalletCoin()
               }.padding(.top, 30)
           }
       }
       
       func setCoinName(){
           appModel.currentCoinName = self.coinName
           viewModel.coinName = self.coinName
           
       }
       func getFirebaseWalletCoin () {
           for tag in viewModel.items {
               if tag.coinName == appModel.chosenCoin?.name ?? " " {
                   self.miktarCoin = tag.coinPiece
               }
               if tag.coinName == "USDT" {
                   self.toplamUsdt = tag.coinPiece
                   self.kullanilabilirUsdt = tag.coinPiece
               }
           }
       }
       
       func getAlert() -> Alert {
           switch alertType {
           case .error:
               return Alert(title: Text("Satın alma gerçekleştirilemedi. Tekrar Deneyin!"))
           case .success:
               return Alert(title: Text("Satın alma işlemi başarı ile gerçekleştirildi!"), message: nil, dismissButton: .default(Text("OK")))
           case .sellSuccess:
               return Alert(title: Text("Satış işlemi başarı ile gerçekleştirildi!"), message: nil, dismissButton: .default(Text("OK")))
           case .sellError:
               return Alert(title: Text("Satış işlemi gerçekleştirilemedi. Tekrar Deneyin!"), message: nil, dismissButton: .default(Text("OK")))

           default:
               return Alert(title: Text("ERROR"))
           }

       }

       
       
       @ViewBuilder
       func GraphView(coin: CryptoModel)->some View{
           GeometryReader{_ in
               // See My Analytics App Video
               // Where I made About Custom Line Graph Video
               // Link in Description
               LineGraph(data: coin.last_7days_price.price,profit: coin.price_change > 0)
           }.frame(width: .infinity, height: 200)
           .padding(.vertical,5)
           //.padding(.bottom,20)
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
                                       appModel.chosenCoin = coin
                                       presentationMode.wrappedValue.dismiss()

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

struct DenemeBuySell_Previews: PreviewProvider {
    static var previews: some View {
        DenemeBuySell().preferredColorScheme(.dark)
    }
}

struct SecondScreens: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var coiName : String
    @ObservedObject var appModel : AppViewModel
    @ObservedObject var viewModel : kullaniciModeliniAlma
    
    var body: some View {
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
                            ForEach(coins){coin in
                                VStack(alignment: .leading, spacing: 10){
                                    HStack(){
                                        AnimatedImage(url: URL(string: coin.image))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Button {
                                                appModel.chosenCoin = coin
                                                viewModel.coinName = appModel.chosenCoin?.name ?? " "
                                                viewModel.listenDocument()
                                                presentationMode.wrappedValue.dismiss()
                                                
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
        }
    }
}
