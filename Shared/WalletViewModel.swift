//
//  WalletViewModel.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 24.04.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase




class GetWalletInformation : ObservableObject{
    @Published var items = [WalletModel]()
    private var db = Firestore.firestore()
    
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
                    data.forEach { (key: String, value: Any) in
                        self.items.append(WalletModel(id: key, coinName: key, coinPiece: value as? Double ?? 0.0))
                    }
                }
            // [END listen_document]
        }

}
