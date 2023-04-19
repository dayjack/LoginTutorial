//
//  UserModel.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/19.
//

import Foundation

//   let user = try? JSONDecoder().decode(UserModel.self, from: jsonData)
struct UserModel: Codable {
    let uid, id, password: String
}


