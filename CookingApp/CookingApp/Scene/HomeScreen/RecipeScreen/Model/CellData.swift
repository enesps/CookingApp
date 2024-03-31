//
//  RecipeModel.swift
//  YapYe
//
//  Created by Enes Pusa on 24.03.2024.
//

import Foundation
struct cellData{
    var sectionType:CellType
    var data:[Any]
}
enum CellType {
    case recipeHeaderTableViewCell
    case recipeTime
    case recipeIngredientsTableViewCell
    case recipeCookingTableViewCell
    
}
