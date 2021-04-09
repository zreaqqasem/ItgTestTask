//
//  User.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//
import Foundation

struct Profile: Codable {
    let login: String?
    let id: Int
    let avatarURL: String?
    let name: String?
    let location: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey,Codable {
        case login, id
        case avatarURL = "avatar_url"
        case name, location, bio
    }
}




