//
//  RecipeModel.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import Foundation
struct Recipe: Codable {
    let id: Int?
    let imageURL: String?
    let recipeName, cookingTime, preparationTime, totalTime: String?
    let servesFor, difficultyLevel, category: String?
    let ingredients: [Ingredient]?
    let instructions: [Instruction]?
    let score: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case recipeName, cookingTime, preparationTime, totalTime, servesFor, difficultyLevel, category, ingredients, instructions, score
    }
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let ingredient, amount: String?
}

// MARK: - Instruction
struct Instruction: Codable {
    let instruction, time: String?
}

struct RecipeDetail {
    var recipeName: String
    var forServes: String
    var cookingTime: String?
    var preparingTime: String?
    var ingredients: [String: [String]]?
    var instructions: [String: String]?
}
struct recipeTimer{
    var  cookingTime, preparationTime, servesFor: String?
}
