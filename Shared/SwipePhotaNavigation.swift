//
//  SwipePhotaNavigation.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 11.05.2022.
//

import SwiftUI

struct SwipePhotaNavigation: View {
    
    @State private var isActive : Bool = false

    var body: some View {
        ScrollView{
            VStack{
                Image("1")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .onTapGesture(count: 1) {
                        NavigationLink(destination: NewsView(), isActive: self.$isActive) {
                            Text("")
                        }
                }
            }
        }
    }
}

struct SwipePhotaNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SwipePhotaNavigation()
    }
}
