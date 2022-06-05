//
//  OneCoinGraph.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 17.04.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class onFavoriCoinClick : ObservableObject{
    @Published var onClick : Bool = false
}


struct OneCoinGraph: View {
    @State var currentCoin: String
    @State var ayrintiliGraph : Bool = false
    
    @StateObject var appModel: AppViewModel = AppViewModel()
    @ObservedObject var cyrpto = CryptoVeriCekme()
    @ObservedObject var girisYapildiMi = girisYapildi()
    @ObservedObject var viewModel = kullaniciModeliniAlma()
    

    //Alert
    @State var showAlert: Bool = false
    @State var alertType: MyAlerts? = nil
    enum MyAlerts {
        case success
        case error
    }
    var body: some View {
        ScrollView{
            if let coins = appModel.coins,let detailGrapUrl = cyrpto.cyrptoUrl{
                ForEach(coins){ coin in
                    if coin.name == currentCoin{
                        VStack(spacing: 5) {
                            HStack{
                                Spacer()
                                AnimatedImage(url: URL(string: coin.image)) // coin resmi
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                Text(coin.name) //coin ismi
                                    .font(.largeTitle)
                                    .foregroundColor(Color.white)
                                    .bold()
                                Spacer()
                                
                                Button {
                                    var db: Firestore!
                                    let settings = FirestoreSettings()
                                    Firestore.firestore().settings = settings
                                    
                                    db=Firestore.firestore()
                                    
                                    let favCoin = db.collection("AllUsers").document(globalEmail)
                                    if globalEmail == " "{
                                        
                                    }
                                    else {
                                        if viewModel.isCoinFav == false { // başlangıçtaki coin, favoriler arasında değilse eklemek için
                                            // Atomically add a new region to the "regions" array field.
                                            favCoin.updateData([
                                                "favoriCoin": FieldValue.arrayUnion([currentCoin]) // favori coinler dizisine coinin ismini ekleyecektir
                                            ])
                                            viewModel.favorilerArasinaEklendi() // button simgesini değiştirmek için çağrılır
                                            alertType = .success
                                            showAlert.toggle()
                                        }
                                        else { // başlangıçtaki coin, favoriler arasındaysa ve silmek istiyorsak
                                            favCoin.updateData([
                                                "favoriCoin": FieldValue.arrayRemove([currentCoin]) // favori coinler dizisinden coinin ismini silecektir
                                            ])
                                            viewModel.favorilerArasindaCikarildi() //button simgesini değiştirmek için çağrılır
                                            alertType = .error
                                            showAlert.toggle()
                                        }
                                    }
                                    
                                    
                                } label: {
                                    if viewModel.isCoinFav == false{
                                        Image(systemName: "star")
                                            .foregroundColor(Color("Renk1"))
                                            .font(.system(size: 23))
                                    }
                                    else {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color("Renk1"))
                                            .font(.system(size: 23))
                                    }
                                    
                                }.padding(.trailing)
                                    .alert(isPresented: $showAlert, content: {
                                    getAlert()
                                })

                            }
                            Text("\("$")\(coin.current_price, specifier: "%.2f")")
                                .font(.body)
                                .fontWeight(.black)
                        }.onAppear{
                            viewModel.favorilerArasindaMi(coinName: coin.name)
                        } // ekran ilk açıldığında coinin favlar arasında yer alıp almadığının kontrolü yapılıp button ona göre şekllenmektedir
                        //hourlyButton()
                        
                        GraphView(coin: coin) // animasyonlu grafiği cizdirecektir
                        CoinDetailTextView(coin: coin).padding(.bottom,10)

                        Button {
                            ayrintiliGraph = true
                        } label: {
                            Text("Ayrıntılı Grafik için Dokunun")
                        }
                        VStack{
                            ForEach(detailGrapUrl){ graphurl in
                                if ayrintiliGraph == true {
                                    if graphurl.coinname == coin.name{
                                        SwiftUIWebView(url: URL(string: graphurl.coingraphurl))
                                            .frame(width: .infinity, height: 500)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                            )
                                    }
                                }
                                
                            }
                        }.padding() // coinin ayrıntılı grafiğini çizdirecektir

                        //GraphView(coin: coin)
                        }
                }
                
            }
            Controls()
            
            
        }.onAppear{
            viewModel.veriYakalama()
            currentCoinName()
        } // ekran ilk açıldığında kullanıcının verilerini oluşturmak için bu fonksiyon çağrılır. Favori coin bilgisini bulabilmek için kullanıcı verilerine ihtiyaç vardır
    }

    func currentCoinName () {
        appModel.currentCoinName = self.currentCoin
    }
    @ViewBuilder
    func Controls()->some View{
        HStack(spacing: 20){
            Button {} label: {
                Text("Sell")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.white)
                    }
            }
            
            Button {} label: {
                Text("Buy")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color("LightGreen"))
                    }
            }
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
        .padding(.vertical,30)
        .padding(.bottom,20)
    }
    func getAlert() -> Alert {
        switch alertType {
        case .error:
            return Alert(title: Text("Favorilerin Arasından Çıkarıldı!"))
        case .success:
            return Alert(title: Text("Favorilerin Arasına Ekledin!"), message: nil, dismissButton: .default(Text("OK")))
        default:
            return Alert(title: Text("ERROR"))
        }

    }
    
    @ViewBuilder
    func CoinDetailTextView(coin : CryptoModel) -> some View{
        VStack(alignment: .leading, spacing: 12){
            HStack{
                Text("Anlık Fiyat: ")
                    .foregroundColor(.gray)
                Text("\("$")\(coin.current_price, specifier: "%.2f")")
                    .bold()
                    //.foregroundColor(Color("Renk1"))
            }
            HStack{
                Text("En Yüksek: ")
                    .foregroundColor(.gray)
                Text("\("$")\(coin.high24H!, specifier: "%.2f")")
                    .bold()
                    //.foregroundColor(Color("Renk1"))
            }
            HStack{
                Text("En Düşük: ")
                    .foregroundColor(.gray)
                //Text("\("$")\(coin.currentPrice, specifier: "%.2f")")
                Text("\("$")\(coin.low24H!, specifier: "%.2f")")
                    .bold()
                    //.foregroundColor(Color("Renk1"))
            }
            HStack{
                Text("Total Volume: ")
                     .foregroundColor(.gray)
                 Text("\("$")\(coin.totalVolume!, specifier: "%.2f")")
                    .bold()
                    //.foregroundColor(Color("Renk1"))
            }
            HStack{
                Text("Değişim Miktarı: ")
                    .foregroundColor(.gray)
                Text("\("$")\(coin.priceChange24H!, specifier: "%.2f")")
                    .bold()
                    //.foregroundColor(Color("Renk1"))

            }
            HStack{
                Text("Son Güncelleme")
                    .foregroundColor(.gray)
                Text(coin.last_updated)
                    .bold()
                    //.foregroundColor(Color("Renk1"))
            }
        }
    }
}

struct OneCoinGraph_Previews: PreviewProvider {
    static var previews: some View {
        OneCoinGraph(currentCoin: "Bitcoin")
            .preferredColorScheme(.dark)
    }
}
