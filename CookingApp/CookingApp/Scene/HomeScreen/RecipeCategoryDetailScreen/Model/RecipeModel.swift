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
