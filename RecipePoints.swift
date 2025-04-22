//
//  RecipePoints.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/12/25.
//

import SwiftUI

struct RecipePoints: View {
    @State private var recipe_points = 4
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("pink_l"))
                    .frame(width:70, height:40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("pink"), lineWidth:3)
                    )
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("pink_c"))
                        .padding(1)
                    Text("4")
                        .foregroundColor(Color("pink"))
                        .font(.system(size:18))
                        .padding(2)
                }
            }
        }
    }
    
}


