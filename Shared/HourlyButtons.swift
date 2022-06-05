//
//  HourlyButtons.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 20.04.2022.
//

import SwiftUI

struct HourlyButtons: View {
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack{
                    // 1h, 24h, 7d, 14d, 30d, 200d, 1y
                    Button { // 1h
                        //graphUrl="https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=1h"
                    } label: {
                        Text("1h")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)
                    
                    Button { // 24h
                        //hourChange.temp = 1
                        //graphUrl="https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
                    } label: {
                        Text("24h")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)

                    Button { // 7d
                        //hourChange.temp = 2
                    } label: {
                        Text("7d")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)

                    Button { // 14d
                        //hourChange.temp = 3
                    } label: {
                        Text("14d")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)
                    
                    Button { // 30d
                        //hourChange.temp = 4
                    } label: {
                        Text("30d")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)
                    
                    Button { // 200d
                        //hourChange.temp = 5
                    } label: {
                        Text("200d")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)
                    
                    Button { // 1y
                        //hourChange.temp = 6
                    } label: {
                        Text("1y")
                            .font(.body)
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }.buttonStyle(.bordered)


                }.frame(width: .infinity, height: 40, alignment: .center)
                    .padding()
            }
            
        }
    }
}

struct HourlyButtons_Previews: PreviewProvider {
    static var previews: some View {
        HourlyButtons()
    }
}
