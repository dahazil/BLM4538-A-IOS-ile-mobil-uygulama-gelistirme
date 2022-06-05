//
//  NewsView.swift
//  MyCyrpto
//
//  Created by Seyfettin Kılınç on 11.05.2022.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        ScrollView{
            if numberImages == 0 {
                VStack{
                    HStack{
                        Text("Kripto")
                            .font(.body)
                            .bold()
                            .foregroundColor(.red)
                            .padding(.leading,20)
                        Spacer()
                        Text("2 saat önce")
                            .padding(.trailing,10)
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                    }.padding(.bottom,10)
                    Text("Herkes aynı soruyu soruyor! Kripto paralarda düşüş nerede duracak? Uzmanlar yorumladı, yatırımcılar dikkat")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("Renk1"))
                        .padding(.leading,10)
                    Image("0")
                        .resizable()
                        .frame(width: .infinity, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.leading,20)
                        .padding(.trailing,20)
                    Text("Kripto para piyasalarında deprem devam ediyor. Lider kripto para birimi Bitcoin 30 bin doların altına sarktı ve 10 ayın dip seviyesini gördü. Tarihi zirvelerinden oldukça uzaklaşan kripto paralarda korku iklimi had safhaya ulaştı. UST'yi 1 dolara eşitlemeye çalışırken elindeki tüm Bitcoinlerden olan Terra başarısız oldu. Luna da bu gelişmeyle birlikte yüzde 90 değer kaybetti. Uzman isimler düşüşleri yorumlarken yatırımcıların nelere dikkat etmesine dikkat çektiler.")
                        .padding()
                    
                    Text("Kripto Para piyasalarına yatırım yapanlar son günlerde ekrandan gözlerini ayıramaz hale geldiler. Kripto paralar kısa sürede büyük kayıplar vermeye başladı ve düşüşlerin devamı da geliyor. Fed’in faizi 50 baz puan artırmasının ardından kısa süreli küçük yükseliş hareketiyle cesaret kazanan yatırımlar bir anda ters hareketle paralarını kaybetmeye başladı. Fed Başkanı Jerome Powell’ın Haziran ve Temmuz’da faiz artırımlarına devam edileceğini, Fed’in bilançosunu Haziran ayından itibaren daraltmaya başlayacağını açıklaması kripto paralarda buhrana yol açtı.")
                        .padding()
                    Text("Fed’in bilançosuyla kripto paralar arasındaki korelasyonun uyumlu olması satışları derinleştirdi. Fed bilançosunu artırdığında kripto paralar yükseliş göstermiş, daralttığında da sert düşüşler görülmüştü.")
                        .padding()
                    
                    HStack{
                        Text("HERKESİN TEK SORUSU VAR: DÜŞÜŞ NEREDE DURACAK")
                            .font(.title3)
                            .bold()
                            .padding(.leading,20)
                        Spacer()
                    }.padding(.bottom,5)
                    
                    Text("Sosyal medyada grafikler, teknik analizler ve tavsiyelerde bulunan uzmanlar nedeniyle birçok yatırımcı ellerindeki varlıkları kaybetti. 2022 yılı sonunda Bitcoin’in çok yüksek miktarlara ulaşacağını iddia eden uzmanlar düşüş karşısında suskunluklarını koruyorlar. Yatırımcılar ise kayıplarının nerede stop edeceğine dikkat kesilmiş durumda.").padding()
                }
            }
            else if numberImages == 1 {
                VStack{
                    Text("Haber2")
                        .font(.largeTitle)
                }
            }
            else if numberImages == 2 {
                VStack{
                    Text("Haber3")
                        .font(.largeTitle)
                }
            }
            else if numberImages == 3 {
                VStack{
                    Text("Haber4")
                        .font(.largeTitle)
                }
            }
            else if numberImages == 4 {
                VStack{
                    Text("Haber5")
                        .font(.largeTitle)
                }
            }
            
        }
        
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .preferredColorScheme(.dark)
    }
}
