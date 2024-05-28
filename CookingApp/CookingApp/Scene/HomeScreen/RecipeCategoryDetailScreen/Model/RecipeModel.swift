//
//  RecipeModel.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import Foundation
struct Recipe: Codable {
    let id: Int?
    let imageURL,image: String?
    var recipeName, cookingTime, preparationTime, totalTime: String?
    let servesFor, difficultyLevel, category: String?
    var ingredients: [Ingredient]?
    var instructions: [Instruction]?
    let score: Int?
    let likeCount: Int?
    let liked, saved: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id

        case imageURL = "imageUrl"
        case image = "image"
        case recipeName, cookingTime, preparationTime, totalTime, servesFor, difficultyLevel, category, ingredients, instructions, score, likeCount, liked, saved 
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
struct InstructionExplanation: Codable {
    let explanation: String?
}
