//
//  ApiConstants.swift
//  CookingApp
//
//  Created by Enes Pusa on 12.12.2023.
//

import Foundation
struct APIConstants {
    static let baseURL = "https://competent-default-execute-seen.trycloudflare.com"
}

class APIEndpoints {
    static let getRecipeCategory = "/v1/recipes/category/"
    static let getRecipeSearch = "/v1/recipes/search"
    static let getRecipeById = "/v1/recipes/"
}

