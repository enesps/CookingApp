//
//  ProfileModel.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.12.2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profile = try? JSONDecoder().decode(Profile.self, from: jsonData)

import Foundation

// MARK: - Profile
struct ProfileModel: Codable {
    let id: Int?
    let email, name, surname: String?
    let socialLoginID: JSONNull?
    let profilePicURL: String?
    let socialTypeLogin, role: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, email, name, surname
        case socialLoginID = "socialLoginId"
        case profilePicURL = "profilePicUrl"
        case socialTypeLogin, role
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
