//
//  NewLoginPage.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 20.04.2022.
//

import SwiftUI
import Firebase



struct NewLoginPage: View {
    @State var girisSekmesi = false
    @State var eposta = ""
    @State var sifre = ""
    @State var securing = true
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack(spacing: 16){
                    Picker(selection: $girisSekmesi, label: Text("")) {
                        Text("Giris Yap").tag(true)
                        Text("Kayıt Ol").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !girisSekmesi {
                        Button {
                            //
                        } label: {
                            //
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .padding()
                        }
                    }
                    
                    Group{
                        TextField("E-Posta", text: $eposta)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)// büyük harfle başlatmama
                        SecureField("Sifre", text: $sifre)
                            .autocapitalization(.none)
                    }.padding()
                    
                    HStack{
                        if girisSekmesi == true {
                            Button {
                                FirebaseAuth.Auth.auth().signIn(withEmail: eposta, password: sifre) { result, error in
                                    if error == nil {
                                        print("Hata Yok")
                                        HomePage()
                                    }
                                }
                            } label: {
                                Text("Giris Yap")
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.system(size: 14, weight: .semibold))

                            }.background(Color.blue).padding()
                        }
                        else {
                            Button {
                                FirebaseAuth.Auth.auth().createUser(withEmail: eposta, password: sifre) { result, error in
                                    if error == nil {
                                        print("Hata Yok")
                                    }
                                }
                            } label: {
                                Text("Kayıt Ol")
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.system(size: 14, weight: .semibold))

                            }.background(Color.blue).padding()
                        }
                        
                    }
        
                }
            }
            .navigationTitle(girisSekmesi ? "Giris Yap" : "Kayıt Ol").background(Color(.init(white:0, alpha: 0.05)).ignoresSafeArea())
        }
    }
}

/* struct NewLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        NewLoginPage()
            .preferredColorScheme(.dark)
    }
} */
