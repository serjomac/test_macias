//
//  Post.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 1/5/22.
//

import Foundation
struct Post: Codable {
    var userID, id: Int
    var title, body: String?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body, isFavorite
    }
}
