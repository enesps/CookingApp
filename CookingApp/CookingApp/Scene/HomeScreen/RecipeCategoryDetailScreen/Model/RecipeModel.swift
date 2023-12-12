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
//struct Recipe: Codable {
//    let imageURL: String?
//    let recipeName, cookingTime, preparationTime, totalTime: String?
//    let servesFor: Int?
//    let difficultyLevel, category: String?
//    let ingredients: [String: [String]]?
//    let instructions: [String: String]?
//    let score: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case imageURL = "imageUrl"
//        case recipeName, cookingTime, preparationTime, totalTime, servesFor, difficultyLevel, category, ingredients, instructions, score
//    }
//}
struct Recipe: Codable {
    let id: Int?
    let imageURL: String?
    let recipeName, cookingTime, preparationTime, totalTime: String?
    let servesFor, difficultyLevel, category: String?
    let ingredients: [String: [String]]?
    let instructions: [String: String]?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case recipeName, cookingTime, preparationTime, totalTime, servesFor, difficultyLevel, category, ingredients, instructions, score
    }
}

