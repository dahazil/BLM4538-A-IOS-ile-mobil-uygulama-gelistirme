//
//  ContentView.swift
//  Shared
//
//  Created by Seyfettin Kılınç on 16.04.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomePage().preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
