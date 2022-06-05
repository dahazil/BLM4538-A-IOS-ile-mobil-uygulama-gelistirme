//
//  LoginView.swift
//  SwiftCyrpto
//
//  Created by Seyfettin Kılınç on 15.04.2022.
//

import SwiftUI
import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

public var globalEmail = " "

class girisYapildi : ObservableObject {
    @Published var giris = 0
    
    @Published var girisYapildiEmail = " "
}

struct userModel : Identifiable{
    var id : String
    var usurName : String
    var telephoneNumber : String
    var favoriCoin = [" "]
}

struct LoginView: View {
    @State var showAlert: Bool = false
    @State var alertType: MyAlerts? = nil
    enum MyAlerts {
        case success
        case error
    }
    
    @ObservedObject var girisYapildiMi : girisYapildi
    
    @State var kullaniciName = ""
    @State var onLogin = true
    @State var password = ""
    @State var email = ""
    @State var phoneNumber = ""
    @State var name = ""
    @State var soyisim = ""
    @State var girisYap = false
    var emptyFavoriCoin : [String] = ["Bitcoin"]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    logo
                    Picker(selection: $girisYap, label: Text("")) {
                        Text("Giris Yap").tag(false)
                        Text("Kayıt Ol").tag(true)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if girisYap == false {
                        Profile
                        passwordEntery
                        VStack{
                            Button {
                                
                            } label: {
                                Text("Parolamı Unuttum!")
                                    .padding()
                            }//.buttonStyle(.borderedProminent)
                            //.controlSize(.mini)
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: .infinity, height: 50)
                                    .foregroundColor(Color("Renk1"))
                                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                                Button {
                                    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                        
                                        if error == nil {
                                            print("Basariyla Giris Yapildi")
                                            girisYapildiMi.giris=1
                                            globalEmail=email
                                        }
                                    }
                                } label: {
                                    Text("Oturumu Aç")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        //.frame(width: .infinity, height: 59)
                                }
                            }
                        }
                    }
                    if girisYap == true {
                        kayitOlTumTextler.padding(.bottom,40)
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: .infinity, height: 50)
                                .foregroundColor(Color("Renk1"))
                                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            Button {
                                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
                                    if error == nil {
                                        print("Hata Yok")
                                        var db: Firestore!
                                        let settings = FirestoreSettings()
                                        Firestore.firestore().settings = settings
                                        
                                        db=Firestore.firestore()
                                        db.collection("AllUsers").document(email).setData([
                                            "name" : name,
                                            "soyisim" : soyisim,
                                            "email" : email,
                                            "usurname" : kullaniciName,
                                            "phoneNumber" : phoneNumber,
                                            "favoriCoin" : emptyFavoriCoin
                                        ]){ err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                                alertType = .error
                                            } else {
                                                print("Document successfully written!")
                                                alertType = .success
                                                showAlert.toggle()
                                            }
                                        }
                                        
                                    }
                                }
                                
                            } label: {
                                Text("Kayıt Ol!")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    //.frame(width: .infinity, height: 59)
                            }.alert(isPresented: $showAlert, content: {
                                getAlert()
                            })
                            
                        }
                        
                        
                    }
                    Spacer()
                    HStack{
                        Text("Üye olmadan giriş yapmak için")
                            .bold()
                        
                        Button {
                        } label: {
                            NavigationLink(destination: NotLoginHomePage()) {
                                Text("Tıklayınız")
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                            
                        }
                    }.padding(.top, 50)
                    .padding(.bottom,50)
                }
                
            }
            

        }
        
    }
    func getAlert() -> Alert {
        switch alertType {
        case .error:
            return Alert(title: Text("Kayıt Olunamadı!"))
        case .success:
            return Alert(title: Text("Basariyla Kayıt Olundu!"), message: nil, dismissButton: .default(Text("OK")))
        default:
            return Alert(title: Text("ERROR"))
        }

    }
}



/*struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().preferredColorScheme(.dark)
    }
}*/

extension LoginView {
    private var logo : some View{
        Image("mainlogo")
            .resizable()
            .font(.system(size: 50))
            .frame(width: 100, height: 100)
            .padding()
    }
    private var Profile : some View{
        HStack{
            VStack(alignment: .leading, spacing: 12){
                Text("Tekrar Merhaba")
                    .fontWeight(.bold)

            }
            Spacer()

        } //Horizantal Stack Bitişi
        .padding()
    }
    
    private var passwordEntery : some View {
        VStack(alignment: .leading, spacing: 10){
            Group{
                Text("Email Giriniz:")
                    .font(.caption)
                    .shadow(color: .red, radius: 10, x: 10, y: 10)
                    .foregroundColor(.gray)
                    .padding(.leading)
                TextField("Email", text: $email)
                    .frame(width: .infinity, height: 40)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                Text("Parolayı Giriniz:")
                    .font(.caption)
                    .shadow(color: .red, radius: 10, x: 10, y: 10)
                    .foregroundColor(.gray)
                    .padding(.leading)
                SecureField("Parola", text: $password)
                    .frame(width: .infinity, height: 40)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
            }
        }
    }
    
    private var kayitOlTumTextler : some View{
        ScrollView{
            VStack(alignment: .leading, spacing: 6){
                VStack(alignment: .leading, spacing: 6){
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
        }.onTapGesture {
            hideKeyboard()
            }
        
    }
}

