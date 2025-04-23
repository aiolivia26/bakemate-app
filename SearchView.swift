//
//  SearchView.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/13/25.
//
import SwiftUI

struct SearchView: View {
    @State private var type_chosen: String = ""
    @State private var type: [String] = [
        "Cake", "Cupcake", "Cookies", "Brownie", "Pie",
        "Donuts", "Bread", "Muffins", "Cinnamon Rolls"
    ]
    @State private var recipes: [Recipe] = []
    @State private var keyword: String = ""
    @State private var image: String = ""
    @Binding var liked_recipes: [Recipe]
    @Binding var completed_recipes: [Recipe]
    
    @Binding var imageName: String

    let apiKey = ""


    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("NEW RECIPE")
                
                VStack(alignment: .leading) {
                    Text("Type of baked good:")
                        .padding(5)
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("pink"))
                            .background(Color("pink_l").cornerRadius(5))
                            .frame(width:350, height:25)
                        Picker("", selection: $type_chosen) {
                            ForEach(type, id:\.self) {i in
                                Text(i)
                            }
                        }
                        .accentColor(Color.black)
                        .offset(x:-120)
                        .padding(.horizontal)
                    }
                    Text("Keywords:")
                        .padding(5)
                    TextField("", text: $keyword)
                        .background(Color("pink_l"))
                        .frame(width:350, height:25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("pink"))
                        )
                }
                
                HStack {
                    Spacer()
                    ZStack {
                        
    
                        NavigationLink {
                            SearchResults(keyword: keyword, type: type_chosen, image: type_chosen, liked_recipes: $liked_recipes, completed_recipes: $completed_recipes, imageName: $imageName)
                                .onAppear {
                                    imageName = type_chosen
                                        }
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:85, height:30)
                                .foregroundColor(Color("pink"))
                        }
                        Text("Search>>").foregroundColor(.white)
                            .font(.system(size:15.5))
                            .padding(26)
                    }
                }
            }
            .offset(y:-200)
        }
    }
}

struct SearchResults: View {
    let keyword: String
    let type: String
    let image: String
    @Binding var liked_recipes: [Recipe]
    @Binding var completed_recipes: [Recipe]
    @Binding var imageName: String
    
    
    @State private var recipes: [Recipe] = []
    
    let apiKey = ""
    
    func fetchRecipes() {
        let q: String = (keyword.isEmpty ? type : "\(keyword) \(type)")

        guard let query = q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&number=10&apiKey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            if let decoded = try? JSONDecoder().decode(RecipeResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.recipes = decoded.results
                }
            }
        }.resume()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("SEARCH RESULTS")
                ForEach(recipes) { recipe in
                    RecipeCards(recipe_ID: recipe.id,title_name: recipe.title, image: image, liked: {
                        liked_recipes.append(recipe)
                    }, completed: {
                        completed_recipes.append(recipe)
                    })
                }
            }
            .onAppear {
                fetchRecipes()
            }
        }
    }
}


