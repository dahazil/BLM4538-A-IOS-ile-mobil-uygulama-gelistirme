//
//  SwipePhoto.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 18.04.2022.
//

import SwiftUI

public var numberImages : Int = 0

struct SwipePhoto: View {
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    private var numberOfImages = 5
    @State private var currentIndex = 0
    
    @State private var isActive_one : Bool = false
    @State private var isActive_two : Bool = false
    @State private var isActive_three : Bool = false
    @State private var isActive_four : Bool = false
    @State private var isActive_five : Bool = false
    
    var array2d : [String : Int] = ["isActive_one" : 1, "isActive_two" : 2 , "isActive_three": 3,"isActive_four":4 , "isActive_five": 5]
    
    @State var temp : Int = 0

    
    func previous(){
        withAnimation {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : numberOfImages - 1
        }
    }
    
    func next(){
        withAnimation {
            currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
        }
    }
    
    var controls : some View{
        HStack{
            Button {
                previous()
            } label: {
                Image(systemName: "chevron.left")
            }
            
            Button {
                next()
            } label: {
                Image(systemName: "chevron.right")
            }
        }
    }
    var body: some View {
        VStack{
            NavigationLink(destination: NewsView(), isActive: self.$isActive_one){
                TabView(selection: $currentIndex){
                    ForEach(0..<numberOfImages){ num in
                        Image("\(num)")
                            .resizable()
                            .scaledToFit()
                            .overlay(Color.black.opacity(0.2))
                            .tag(num)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .onTapGesture {
                                numberImages = num
                                isActive_one=true
                                
                            }
                    }
                }.tabViewStyle(PageTabViewStyle())
                    //.padding(.trailing,10)
                    //.padding(.leading,10)
                    .frame(width: .infinity, height: 150)
                    .onReceive(timer) { _ in
                        next()
                        // set the page to next image
                    }
            }
            //controls
            PopulerCoinView()
                .padding(.top,10)
           
        }
    }
}

struct SwipePhoto_Previews: PreviewProvider {
    static var previews: some View {
        SwipePhoto()
    }
}
