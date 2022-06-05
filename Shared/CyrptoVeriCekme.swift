//
//  CyrptoVeriCekme.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 20.04.2022.
//

import Foundation
import Firebase

class CryptoVeriCekme : ObservableObject{
    
    @Published var cyrptoUrl = [CyrptoGraphUrlModel]()
    
    init(){
        verileriAlma()
    }
    
    func verileriAlma(){
        let database = Firestore.firestore()
        // collectiondaki isim
        database.collection("AllUrl").getDocuments { snapshot, error in
            if error == nil {
                //HATA ALINMADIYSA
                if let snapshot = snapshot {
                    DispatchQueue.main.async { // ana threadde çalışsın ancak diğer kodları etkilemesin
                        self.cyrptoUrl = snapshot.documents.map({ veriler in // gelecek dizileri kullanici listesine eşitledik
                            return CyrptoGraphUrlModel(id: veriler.documentID, coinname: veriler["coinName"] as? String ?? "", coingraphurl: veriler["coinGraphUrl"] as? String ?? "")
                        })
                    }
                }
            }
            else {
                //HATA ALINDIYSA
            }
            
        }
    }
    
}
