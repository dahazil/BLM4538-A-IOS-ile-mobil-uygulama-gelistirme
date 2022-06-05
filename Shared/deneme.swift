//
//  deneme.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 18.04.2022.
//

import SwiftUI


struct deneme: View {
    @State var kullaniciName = ""
    @State var onLogin = true
    @State var password = ""
    @State var email = ""
    @State var phoneNumber = ""
    @State var name = ""
    @State var soyisim = ""
    @State var girisYap = false
    var body: some View {
        VStack{
            Picker(selection: $girisYap, label: Text("")) {
                Text("Giris Yap").tag(false)
                Text("Kayıt Ol").tag(true)
            }.pickerStyle(SegmentedPickerStyle())
            ScrollView{
                VStack(alignment: .leading, spacing: 5){
                    VStack(alignment: .leading, spacing: 5){
                        Text("Adınızı Giriniz: ")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        TextField(" Adınız", text: $name)
                            .background(Color.white.opacity(0.1).cornerRadius(5))
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                        Text("Soyadınızı Giriniz: ")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        TextField(" Soyadınız", text: $soyisim)
                            .background(Color.white.opacity(0.1).cornerRadius(5))
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                    }
                    
                    Text("Kullanıcı Adı Giriniz: ")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    TextField(" Kullanıcı adı", text: $kullaniciName)
                        .background(Color.white.opacity(0.1).cornerRadius(5))
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                    Text("E-posta Giriniz:")
                        .font(.caption)
                        .shadow(color: .red, radius: 10, x: 10, y: 10)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    TextField("E-posta", text: $email)
                        .frame(width: .infinity, height: 40)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                    Text("Parolayı Giriniz:")
                        .font(.caption)
                        .shadow(color: .red, radius: 10, x: 10, y: 10)
                        .foregroundColor(.gray)
                        .autocapitalization(.none)
                        .padding(.leading)
                    SecureField("Parola", text: $password)
                        .frame(width: .infinity, height: 40)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                    Text("Telefon Giriniz: ")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    TextField(" +90", text: $phoneNumber)
                        .background(Color.white.opacity(0.1).cornerRadius(5))
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                }
            }
        }
    }
}

struct deneme_Previews: PreviewProvider {
    static var previews: some View {
        deneme()
            .preferredColorScheme(.dark)
    }
}
