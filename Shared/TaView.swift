//
//  TaView.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 11.05.2022.
//

import SwiftUI

struct TaView: View {
    @ObservedObject var taViewModel : TAAnaliys = TAAnaliys()
    var body: some View {
        VStack{
            Text("\(taViewModel.myValue)")
                .font(.largeTitle)
        }
    }
}

struct TaView_Previews: PreviewProvider {
    static var previews: some View {
        TaView()
            .preferredColorScheme(.dark)
    }
}
