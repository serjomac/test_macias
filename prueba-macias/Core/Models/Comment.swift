//
//  Comment.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import Foundation

struct Comment: Codable {
    let postID, id: Int
    let name, email, description: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case description = "body"
        case id, name, email
    }
}
