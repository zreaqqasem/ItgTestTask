//
//  UserListModel.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int


    enum CodingKeys: String, CodingKey {
        case login, id
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}
typealias Users = [User]


