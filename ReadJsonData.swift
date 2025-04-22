//
//  ReadJsonData.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/21/25.
//

import Foundation

struct RecipeResponse: Codable {
    let results: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let instructions: String?
}

struct AnalyzeInstruction: Codable {
    let name: String
    let steps: [InstructionStep]
}

struct InstructionStep: Codable {
    let number: Int
    let step: String
    let ingredients: [Step]
}

struct Step: Codable {
    let id: Int
    let name: String
}
