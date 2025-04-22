//
//  RecipesView.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/13/25.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        VStack() {
            Text("Your Recipes").font(.title2).bold()
                .padding(7)
            VStack(alignment: .leading) {
                Text("COMPLETED RECIPES")
//                RecipeCards(title_name: "Cinnamon Rolls", image: "cinnamon")
            }
            .padding()
            VStack(alignment: .leading) {
                Text("LIKED RECIPES")
            }
            .padding()
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}


#Preview {
    RecipesView()
}
