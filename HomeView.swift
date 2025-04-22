//
//  HomeView.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/12/25.
//
import SwiftUI

struct HomeView: View {
//    var saved_recipes: [RecipeCards]
    @State private var type_chosen: String = ""
    @State private var num = 3
    @State private var pressed = false
    @State private var liked_recipes: [Recipe] = []
    @State private var completed_recipes: [Recipe] = []
    
    @State private var imageName: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                RecipePoints()
                HStack {
                    BakeMateHamster()
                        .padding(9)
                    BakingTimer()
                }
                ScrollView {
                    VStack(alignment:.leading) {
                        Text("SAVED RECIPES")
                            .padding(4)
                            .font(.system(size:16))
                        ForEach(liked_recipes) { recipe in
                            RecipeCards(recipe_ID: recipe.id, title_name: recipe.title, image: imageName, liked: {if !liked_recipes.contains(where: { $0.id == recipe.id }) {
                                liked_recipes.append(recipe)}}, completed: {if !completed_recipes.contains(where: { $0.id == recipe.id }) {
                                    completed_recipes.append(recipe)
                                    }})
                        }
                    }
                }
                AddNewRecipe(type_chosen: $type_chosen,liked_recipes: $liked_recipes, completed_recipes: $completed_recipes, imageName: $imageName).offset(x:290, y:-60)
            }.frame(maxWidth: 350)
        }
    
    }
    
}

struct AddNewRecipe: View {
    @State private var pressed = false
    @Binding var type_chosen: String
    @Binding var liked_recipes: [Recipe]
    @Binding var completed_recipes: [Recipe]
    @Binding var imageName: String
    
    var body: some View {
        VStack {
            Button {
                pressed = true
            } label: {
                ZStack {
                    Circle()
                        .frame(width:65)
                        .foregroundColor(Color("pink_c"))
                        .shadow(color:.gray.opacity(0.4), radius: 10, x:5, y:5)
                    Image(systemName: "plus").font(.system(size:35))
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $pressed) {
                SearchView(liked_recipes: $liked_recipes, completed_recipes: $completed_recipes, imageName: $imageName)
            }
        }
    }
}



#Preview {
    HomeView()
}
