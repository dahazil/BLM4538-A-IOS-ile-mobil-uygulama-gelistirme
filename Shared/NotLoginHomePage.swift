//
//  NotLoginHomePage.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 1.05.2022.
//

import SwiftUI

struct NotLoginHomePage: View {
    private var numberOfImages = 5
    @State var onLogin : Bool = true
    @State var temp : Double = 0.06

    @StateObject var appModel: AppViewModel = AppViewModel()
    @StateObject var loginScrren : OpeningScreen = OpeningScreen()
    @ObservedObject var girisYapildiMi = girisYapildi()
    var body: some View {
        ScrollView{
            //homePageTopButton
            SwipePhoto().padding(.bottom,20)
            AllCoinList()
            // haberler ve populer coinleri bastırır
        }
    }
}

struct NotLoginHomePage_Previews: PreviewProvider {
    static var previews: some View {
        NotLoginHomePage()
    }
}

extension NotLoginHomePage {
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
