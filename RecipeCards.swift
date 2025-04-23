//
//  RecipeCards.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/13/25.
//

import SwiftUI


struct RecipeCards: View {
    @State private var steps: [(Int, String)] = []
    @State private var loaded = false
    @State private var like = false
    @State private var complete = false
    
    
    var recipe_ID: Int
    var title_name: String
    var image: String
    var liked: () -> Void
    var completed: () -> Void
    
    func fetchInstructions(for id: Int) {
        let APIKey = ""
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=\(APIKey)") else {return}
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {
                print("N/a")
                return
            }
            do {
                let analyzed = try JSONDecoder().decode([AnalyzeInstruction].self, from: data)
                if let first = analyzed.first {
                    DispatchQueue.main.async {
                        self.steps = first.steps.map { ($0.number, $0.step) } //WHAAAAA
                        self.loaded = true
                    }
                } else {
                    print("No instructions returned")
                }
            } catch {
                print("Decoding error:", error)
            }
            
        }.resume()
    }
    
    var body: some View {
        NavigationLink {
            RecipeFullView(
                title_name: title_name,
                instructions: loaded
                ? steps.map { "\($0.0). \($0.1)" }.joined(separator: "\n")
                : "loading..."
            )
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 7).fill(.white)
                        .frame(width:350, height:104)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(style: StrokeStyle(
                                    lineWidth: 0.9, dash: [8]))
                                .foregroundColor(Color("grey_line"))
                        )
                    HStack {
                        Image(image)
                            .resizable()
                            .frame(width: 60, height:60)
                            .padding(-6)
                        VStack(alignment:.leading) {
                            Text(title_name.capitalized).font(.headline)
                                .lineLimit(1)
                                .frame(maxWidth:227, alignment: .leading)
                            VStack {
                                ForEach(0..<min(steps.count, 3), id: \.self) { i in
                                    Text(steps[i].1)
                                }
                            }
                            .font(.subheadline)
                            .lineLimit(3)
                            .truncationMode(.tail)
                            .frame(maxWidth:240, maxHeight: 50, alignment:.leading)
                        }
                        VStack {
                            LikedRecipes(like: $like, liked:liked).offset(y:-19)
                            CompleteRecipe(complete: $complete, completed:completed).offset(y:20)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchInstructions(for: recipe_ID)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    struct LikedRecipes: View {
        @Binding var like: Bool
        var liked: () -> Void
        
        var body: some View {
            Button {
                like.toggle()
                if like {
                    liked()
                }
            } label: {
                HStack {
                    if (like == true) {
                        Image(systemName: "heart.fill")
                            .font(.system(size:20))
                            .foregroundColor(Color("pink"))
                    }
                    else {
                        Image(systemName: "heart")
                            .font(.system(size:20))
                            .foregroundColor(Color("pink"))
                    }
                }
                
                
            }
        }
    }
}
    
    struct CompleteRecipe: View {
        @Binding var complete: Bool
        var completed: () -> Void
        
        var body: some View {
            Button {
                complete.toggle()
                if complete {
                    completed()
                }
            } label: {
                if (complete == true) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size:20))
                        .foregroundColor(Color("light_green"))
                }
                else {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size:20))
                        .foregroundColor(Color("light_green"))
                    
                }
            }
        }
    }
    
    struct RecipeFullView: View {
        var title_name: String
        var instructions: String
        
        var body: some View {
            VStack {
                Text(title_name.capitalized).font(.title3).bold()
                Text(instructions).padding()
            }
            Spacer()
        }
    }
    
