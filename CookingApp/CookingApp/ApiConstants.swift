//
//  ApiConstants.swift
//  CookingApp
//
//  Created by Enes Pusa on 12.12.2023.
//

import Foundation
struct APIConstants {
    static let baseURL = "https://partnership-heritage-warnings-strictly.trycloudflare.com"
}

class APIEndpoints {
    static let getRecipeCategory = "/v1/recipes/category/"
    static let getRecipeSearch = "/v1/recipes/search"
    static let getRecipeById = "/v1/recipes/"
    static let getRecipeDaily = "/v1/recipes/recipe-of-the-day"
    static let getRecipes = "/v1/recipes"
    static let getGoogleLogin = "/v1/members/login/google"
    static let getProfile = "/v1/members"
    static let getSaveList = "/v1/recipes/saved"
    static let getLikeList = "v1/recipes/liked"
    static let recipeLikeList = "/v1/recipes/{recipeId}/like"
    static let recipeSave = "/v1/recipes/{recipeId}/save"
    
}

