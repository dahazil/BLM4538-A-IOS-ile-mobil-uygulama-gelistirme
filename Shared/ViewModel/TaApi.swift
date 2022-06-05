//
//  TaApi.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 11.05.2022.
//

import Foundation



struct IndicatorModel : Decodable{
    var value : Double
}

class TAAnaliys : ObservableObject {
    @Published var indicator : IndicatorModel?
    @Published var myValue : Double = 1.0

    let secretKey : String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF6aWx6aXlhbjIwQGdtYWlsLmNvbSIsImlhdCI6MTY1MjI5MDY0OSwiZXhwIjo3OTU5NDkwNjQ5fQ.0aRenvO-ec0J8m8BUzpZJhRAxjz3PB3O_lmoTw_lAlg"
    
    init(){
        Task{
            do{
                try await fetchCryptoData()
            }catch{
                // HANDLE ERROR
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Fetching Crypto Data
    func fetchCryptoData()async throws{
        // MARK: Using Latest Async/Await
        guard let url = URL(string: "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF6aWx6aXlhbjIwQGdtYWlsLmNvbSIsImlhdCI6MTY1MjI5MDY0OSwiZXhwIjo3OTU5NDkwNjQ5fQ.0aRenvO-ec0J8m8BUzpZJhRAxjz3PB3O_lmoTw_lAlg&exchange=binance&symbol=BTC/USDT&interval=1h") else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode(IndicatorModel.self, from: response.0)
        self.myValue = jsonData.value
        
        // Alternative For DispatchQueue Main
        await MainActor.run(body: {
            self.myValue = jsonData.value
            //self.indicator = jsonData
        })
    }
    
    
    
}
