//
//  HomePage.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 18.04.2022.
//

import SwiftUI
import SDWebImageSwiftUI



class OpeningScreen : ObservableObject {
    @Published var login : Bool = false
    @Published var logedIn : Bool = false
}


struct FirstOpeningScreen: View {
    @ObservedObject var loginScrren : OpeningScreen
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                Image("mainlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 128, height: 128)
                Text("MyCyrpto")
                    .font(.system(size: 50))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.pink)
                Text("Welcome")
                    .bold()
                Spacer()
                HStack{
                    Text("Üye olmadan giriş yapmak için")
                        .bold()
                    
                    Button {
                        loginScrren.login=false
                    } label: {
                        Text("Tıklayınız")
                            .bold()
                    }.foregroundColor(.black)
                }.padding(.bottom,50)
            }
            
        }
    }
}

struct HomePage: View {
    private var numberOfImages = 5
    @State var onLogin : Bool = true
    @State var temp : Double = 0.06

    @StateObject var appModel: AppViewModel = AppViewModel()
    @StateObject var loginScrren : OpeningScreen = OpeningScreen()
    @ObservedObject var girisYapildiMi = girisYapildi()
    var body: some View {
        NavigationView{
            if loginScrren.login == true {
                FirstOpeningScreen(loginScrren: loginScrren).ignoresSafeArea()
            }
            else if loginScrren.login == false{
                ScrollView{
                    //homePageTopButton
                    SwipePhoto().padding(.bottom,20)
                    AllCoinList()
                    // haberler ve populer coinleri bastırır
                }.navigationTitle("Anasayfa").padding()
            }
            
            
        }//.environmentObject(loginScrren)
            // Navigation View, her şey burada olacak.
            
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .preferredColorScheme(.dark)
    }
}

extension HomePage {
    private var homePageTopButton : some View{
        HStack{
            Button {
                
            } label: {
                if girisYapildiMi.giris == 0 {
                    NavigationLink(destination: LoginView(girisYapildiMi: girisYapildiMi)) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("Renk1"))
                            .padding(.leading,20)
                    }
                }
                else {
                    NavigationLink(destination: Profile()) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("Renk1"))
                            .padding(.leading,20)
                    }
                }
            }
            
            Text(girisYapildiMi.giris == 0 ? "Kayıt Ol / Giris Yap" : "Profile" )
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
            
            Spacer()
            
            if girisYapildiMi.giris != 0 {
                Button {
                    
                } label: {
                    if girisYapildiMi.giris == 0 {
                        NavigationLink(destination: BuySellView()){
                            Image(systemName: "wallet.pass")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("Renk1"))
                                .padding(.trailing, 20)

                        }
                    }
                    else{
                        NavigationLink(destination: BuySellView()){
                            Image(systemName: "wallet.pass.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("Renk1"))
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
            Button {
                
            } label: {
                NavigationLink(destination: Search()) {
                    Image(systemName: "sparkle.magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("Renk1"))
                        .padding(.trailing, 20)
                }
            }
        }.padding(.bottom)
    }
    
}


struct TabView_ScreenBackgroundColor: View {
    let gradient = LinearGradient(colors: [.orange, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
    var body: some View {
        TabView {
            ZStack {
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Background colors can be seen behind the TabView")
                        .padding()
                }
                .font(.title2)
            }
            .tabItem {
                Image(systemName: "star")
                Text("Tab 1")
            }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "moon")
                    Text("Tab 2")
                }
            
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Tab 3")
                }
        }
    }
}
