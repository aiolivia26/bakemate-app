//
//  MainView.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/12/25.
//


import SwiftUI

struct MainView: View {
    @State var goHome = false
    
    var body: some View {
        
        if goHome {
            TabBarView()
        }
        else {
            VStack {
                Text("Welcome to")
                    .font(.system(size:40))
                    .padding(-3)
                
                HStack {
                    Text("Bake")
                        .font(.system(size:40))
                        .padding(-7)
                        .foregroundColor(Color("pink"))
                    Text("Mate")
                        .font(.system(size:40))
                        .foregroundColor(Color("light_green"))
                }
                .padding(-5)
                
                Image("apron")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height:160)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("pink_l"))
                        .frame(width: 400, height:90)
                        .offset(x:0, y:240)
                    
                    Button {
                        goHome = true
                    } label: {
                        ZStack {
                            Rectangle().cornerRadius(30)
                                .frame(width:230, height:55)
                                .foregroundColor(Color("pink_c"))
                            Text("CONTINUE")
                                .foregroundColor(.white)
                                .font(.system(size:22))
                        }
                        .padding(.top, 390)
                    }
                    
                    
                }
                .padding(-200)
            }
        }
    }
}

#Preview {
    MainView()
}
