//
//  AddRecipeModel.swift
//  CookingApp
//
//  Created by Enes Pusa on 4.01.2024.
//

import Foundation
struct AddRecipeModel:Codable{
    var imageUrl:String?
    var recipeName,preparationTime,cookingTime :String?
    var servesFor,category:String?
    var ingredients: [AddIngredient]?
    var instructions: [AddInstruction]?
}
struct AddIngredient: Codable {
    var ingredient, amount: String?
}

// MARK: - Instruction
struct AddInstruction: Codable {
    var instruction, time: String?
}
