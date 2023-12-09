//
//  RecipeModel.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import Foundation
struct recipeModel1:Decodable{
    
}
struct Welcome: Codable {
    let count: Int?
    let name: String?
    let age: Int?
}
struct Recipe: Codable {
    let imageURL: String?
    let recipeName, cookingTime, preparationTime, totalTime: String?
    let servesFor: Int?
    let difficultyLevel, category: String?
    let ingredients: [String: [String]]?
    let instructions: [String: String]?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case recipeName, cookingTime, preparationTime, totalTime, servesFor, difficultyLevel, category, ingredients, instructions, score
    }
}

class RecipeModel{
    
    var recipeImage:String
    var recipeName:String
    var recipeScore:String
    var recipeCookingTime: String
    var recipeDifficultyLevel:String
    init(recipeImage: String, recipeName: String, recipeScore: String, recipeCookingTime: String, recipeDifficultyLevel: String) {
        self.recipeImage = recipeImage
        self.recipeName = recipeName
        self.recipeScore = recipeScore
        self.recipeCookingTime = recipeCookingTime
        self.recipeDifficultyLevel = recipeDifficultyLevel
    }
    
}
