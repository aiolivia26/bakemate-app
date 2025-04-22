//
//  BakeMateHamster.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/14/25.
//

import SwiftUI


struct BakeMateHamster: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .frame(width:160, height:150)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(style: StrokeStyle(
                            lineWidth: 0.9, dash: [8]))
                        .foregroundColor(Color("grey_line"))
                )
            Image("hamster")
                .resizable()
                .frame(width:120, height:120)
                .offset(y:15)
            Rectangle()
                .frame(width:159, height:26)
                .foregroundColor(Color("light_green"))
                .offset(y:64)
        }
    }
}
    
#Preview {
    BakeMateHamster()
}
