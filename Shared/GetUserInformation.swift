//
//  GetUserInformation.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 21.04.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct myUserModel : Identifiable{
    var id : String = UUID().uuidString
    var email : String
    var name : String
    var phoneNumber : String
    var soyisim : String
    var usurname : String?
    var favoriCoin : [String] = []
}

struct WalletModel : Identifiable {
    var id : String
    var coinName : String
    var coinPiece : Double
}

/*struct UsdtModel : Identifiable{
    var id : String?
    var coinName : String?
    var coinPiece : Double?
}*/


/* let dataDescription = document.data().map{_ -> myUserModel in
 let email = dataDescription!.email
 let name = dataDescription!.name
 let phoneNumber = dataDescription!.phoneNumber
 let soyisim = dataDescription!.soyisim
 let usurname = dataDescription!.usurname
   return myUserModel(id: .init(), email: email, name: name, phoneNumber: phoneNumber, soyisim: soyisim, usurname: usurname)
}*/
class kullaniciModeliniAlma : ObservableObject{
    @Published var myUser = [myUserModel]()
    @Published var isCoinFav : Bool = false
    @Published var items = [WalletModel]()
    //@Published var oneWallet = [WalletModel]()
    //@Published var usdtWallets = [UsdtModel]()
    
    
    @Published var coinName = "Ethereum"
    @Published var usdtPieces : Double = 0.0
    @Published var oneWalletPieces : Double = 0.0
    
    public var count = 0
    @Published var denemeDicValue : [String : Double] = [" ": 0.0]
    
    //@Published var totalCapitalValue : Double = 0.0
    
    @ObservedObject var girisYapildiMi = girisYapildi()
    

    //@ObservedObject var appModel : AppViewModel = AppViewModel()

    
    public var myFavoriCoin : [String] = []
    var coinFav : [String] = []
    
    private var db = Firestore.firestore()
    
    /* init(girisYapildiMi : girisYapildi){
        self.girisYapildiMi=girisYapildiMi
    } */
    
    init(){
        listenDocument()
        SellBuyCoinsData()
    }
    func veriYakalama() {
        getArray()
        print(myFavoriCoin)
        db.collection("AllUsers").whereField("email", isEqualTo: globalEmail)
                    .addSnapshotListener { querySnapshot, error in
                        guard let documents = querySnapshot?.documents else {
                            print("Error fetching documents: \(error!)")
                            return
                        }
                        self.myUser = documents.map { queryDocumentSnapshot -> myUserModel in
                          let data = queryDocumentSnapshot.data()
                          let email = data["email"] as? String ?? ""
                            let name = data["name"] as? String ?? ""
                            let phoneNumber = data["phoneNumber"] as? String ?? ""
                            let soyisim = data["soyisim"] as? String ?? ""
                            let usurname = data["usurname"] as? String ?? ""
                            self.coinFav = data["favoriCoin"] as? Array ?? [""]
                            
                            /*let coin = data["favoriCoin"].map { indis in
                                self.favoriCoin.append(indis as! String)
                            } */
                            return myUserModel(id: .init(), email: email, name: name, phoneNumber: phoneNumber, soyisim: soyisim, usurname: usurname, favoriCoin: self.coinFav)
                            
                        }
                    }
    }
    
      
    func listenDocument() {
            // [START listen_document]
            db.collection("AllUsersWallet").document(globalEmail)
                .addSnapshotListener { documentSnapshot, error in
                  guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                  }
                  guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                  }
                    print("Current data: \(data)")
                    if self.items.isEmpty == true{
                        data.forEach { (key: String, value: Any) in
                            self.items.append(WalletModel(id: key, coinName: key, coinPiece: value as? Double ?? 0.0))
                        }
                    }
                    else {
                        self.items.removeAll()
                        data.forEach { (key: String, value: Any) in
                            self.items.append(WalletModel(id: key, coinName: key, coinPiece: value as? Double ?? 0.0))
                        }
                    }
                    
                    
                }
            // [END listen_document]
        }
    
    /* func TotalCapital(){
        self.totalCapitalValue = 0.0
        let coins = appModel.walletCoin
        self.items.forEach { WalletModel in
            coins.forEach { CryptoModel in
                if WalletModel.coinName == CryptoModel.name {
                    self.totalCapitalValue = self.totalCapitalValue + (WalletModel.coinPiece * CryptoModel.current_price)
                }
            }
        }
    } */
    
    func SellBuyCoinsData() {
            // [START listen_document]
            db.collection("AllUsersWallet").document(globalEmail)
                .addSnapshotListener { documentSnapshot, error in
                  guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                  }
                  guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                  }
                    print("Current data: \(data)")
                    
                    data.forEach { (key: String, value: Any) in
                        if key == self.coinName{
                            self.oneWalletPieces = value as? Double ?? 0.0
                            self.count = self.count + 1
                            //self.oneWallet.append(WalletModel(id: key, coinName: key, coinPiece: value as? Double ?? 0.0))
                        }
                        else if key == "USDT" {
                            self.usdtPieces = value as! Double
                            //self.usdtWallets.append(UsdtModel(id: key, coinName: key, coinPiece: value as? Double ?? 0.0))
                        }
                        //self.items.append(WalletModel(id: key, coinName: key, coinPiece: value as? Double ?? 0.0))
                    }
                    if self.count == 0 {
                        self.oneWalletPieces = 0.0
                    }
                }
        self.count = 0
            // [END listen_document]
        }

    
    func favorilerArasindaMi(coinName : String){
        for tag in coinFav {
            if tag == coinName {
                isCoinFav = true
            }
        }
    }
    
    func favorilerArasindaCikarildi(){
        isCoinFav=false
    }
    
    func favorilerArasinaEklendi(){
        isCoinFav=true
    }
    
    func getArray () {
        db.collection("AllUsers").document(girisYapildiMi.girisYapildiEmail).getDocument {
            (document, error) in
            if let document = document {
                self.myFavoriCoin = document["favoriCoin"] as? Array ?? [""]
                
            }
        }
    }
}
