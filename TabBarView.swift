//
//  TabBarView.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/13/25.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            RecipesView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Recipes")
                }
            
        }
        .accentColor(Color("pink"))
    }
}

#Preview {
    TabBarView()
}
