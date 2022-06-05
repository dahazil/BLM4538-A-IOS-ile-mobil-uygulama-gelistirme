//
//  UserInformation.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 21.04.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase


struct UserInformation: View {
    @ObservedObject var viewModel = kullaniciModeliniAlma()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 15){
                Text("Burada kişisel bilgilerin yer almaktadır. Bu kısmı sadece sen görüntüleyebilirsin. ")
                    .font(.system(size: 20))
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                List(viewModel.myUser){ alluser in
                    HStack(spacing: 20){
                        Text("İsim: ")
                            .font(.system(size: 20))
                            .padding(.leading,10)
                            .foregroundColor(Color("Renk1"))
                            
                        Text(alluser.name)
                            .font(.system(size: 20))
                    }.padding(.bottom)
                    HStack(spacing: 20){
                        Text("Soyisim: ")
                            .font(.system(size: 20))
                            .padding(.leading,10)
                            .foregroundColor(Color("Renk1"))
                        Text(alluser.soyisim)
                            .font(.system(size: 20))
                    }.padding(.bottom)
                    HStack(spacing: 20){
                        Text("Kullanıcı Adı: ")
                            .font(.system(size: 20))
                            .padding(.leading,10)
                            .foregroundColor(Color("Renk1"))
                        Text(alluser.usurname ?? "Bosluk")
                            .font(.system(size: 20))
                    }.padding(.bottom)
                    HStack(spacing: 20){
                        Text("Email: ")
                            .font(.system(size: 20))
                            .padding(.leading,10)
                            .foregroundColor(Color("Renk1"))
                        Text(alluser.email)
                            .font(.system(size: 20))
                    }.padding(.bottom)

                    HStack(spacing: 20){
                        Text("Telefon Numaran: ")
                            .font(.system(size: 20))
                            .padding(.leading,10)
                            .foregroundColor(Color("Renk1"))
                        Text(alluser.phoneNumber)
                            .font(.system(size: 20))
                    }.padding(.bottom)
                }.listStyle(.plain)
                .onAppear(){
                    self.viewModel.veriYakalama()
                }
                
            }
            
        }
        
    }
    func createDb () {
        
    }
}
struct UserInformation_Previews: PreviewProvider {
    static var previews: some View {
        UserInformation()
            .preferredColorScheme(.dark)
    }
}
