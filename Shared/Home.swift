//
//  Home.swift
//  CryptoApp (iOS)
//
//  Created by Balaji on 10/04/22.
//



/*

struct Home: View {
    @State var currentCoin: String = "BTC"
    @Namespace var animation
    @State var loginn : Bool = false
    @StateObject var appModel: AppViewModel = AppViewModel()
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    if let coins = appModel.coins,let coin = appModel.currentCoin{
                        // MARK: Sample UI
                        HStack(spacing: 15){
                            AnimatedImage(url: URL(string: coin.image))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(coin.name)
                                    .font(.callout)
                                Text(coin.symbol.uppercased())
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        CustomControl(coins: coins)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(coin.current_price.convertToCurrency())
                                .font(.largeTitle.bold())
                                .foregroundColor(coin.price_change > 0 ? Color("LightGreen") : .red)
                            
                            // MARK: Profit/Loss
                            Text("\(coin.price_change > 0 ? "+" : "")\(String(format: "%.2f", coin.price_change))")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(coin.price_change < 0 ? .white : .black)
                                .padding(.horizontal,10)
                                .padding(.vertical,5)
                                .background{
                                    Capsule()
                                        .fill(coin.price_change < 0 ? .red :Color("LightGreen"))
                                }
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)

                        GraphView(coin: coin)
                        
                        Controls()
                    }
                    else{
                        ProgressView()
                            .tint(Color("LightGreen"))
                    }
                } // grafikler vs hepsi
                Spacer()
                HStack(spacing: 40){
                    homeButton
                    searcButton
                    personButton
                }.padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
        }
    }
    
    
    @ViewBuilder
    func LoginPage()->some View{
        //LoginView()
    }
    // MARK: Line Graph
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
    
    // MARK: Custom Segmented Control
    @ViewBuilder
    func CustomControl(coins: [CryptoModel])->some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15){
                ForEach(coins){coin in
                    Text(coin.symbol.uppercased())
                        .foregroundColor(currentCoin == coin.symbol.uppercased() ? .white : .gray)
                        .padding(.vertical,6)
                        .padding(.horizontal,10)
                        .contentShape(Rectangle())
                        .background{
                            if currentCoin == coin.symbol.uppercased(){
                                Rectangle()
                                    .fill(Color("Tab"))
                                    .matchedGeometryEffect(id: "SEGMENTEDTAB", in: animation)
                            }
                        }
                        .onTapGesture {
                            appModel.currentCoin = coin
                            withAnimation{currentCoin = coin.symbol.uppercased()}
                        }
                }
            }
        }
        .background{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(Color.white.opacity(0.2),lineWidth: 1)
        }
        .padding(.vertical)
    }
    
    // MARK: Controls
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
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Home {
    
    private var homeButton  : some View {
        VStack{
            Button {
                
            } label: {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("Renk1"))
            }.buttonStyle(.bordered)
        }
    }
    private var searcButton : some View {
        VStack{
            Button {
        
                
            } label: {
                NavigationLink(destination: Search()) {
                    Image(systemName: "sparkle.magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("Renk1"))
                }
            }.buttonStyle(.bordered)
        }
    }
    
    private var personButton : some View {
        VStack{
            Button {

            } label: {
                NavigationLink(destination: Profile()) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("Renk1"))
                }
            }.buttonStyle(.bordered)
        }
    }
}
// MARK: Converting Double to Currency
*/
