//
//  PostService.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 1/5/22.
//

import Foundation
import Alamofire
import UIKit

class PostService {
    func GetAllPost(completionHandler: @escaping ([Post]?, Error?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/posts").responseDecodable(of: [Post].self, queue: .main, decoder: JSONDecoder()) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data, nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
    func GetCommentsByPost(postID: Int, completionHandler: @escaping ([Comment]?, Error?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/comments", parameters: ["postId": postID]).responseDecodable(of: [Comment].self, queue: .main, decoder: JSONDecoder()) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data, nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
    func GetUser(userId: Int, completionHandler: @escaping ([User]?, Error?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/users", parameters: ["id": userId]).responseDecodable(of: [User].self, queue: .main, decoder: JSONDecoder()) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data, nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
}
