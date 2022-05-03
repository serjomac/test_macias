//
//  PostDataSource.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 1/5/22.
//

import Foundation
import UIKit

class PostDataSource: NSObject, UITableViewDataSource {
    private var count = 0
    
    var posts: [Post]? {
        didSet {
            self.count = 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostTableViewCell
        cell?.postTitle.text = self.posts?[indexPath.row].title
        if (posts?[indexPath.row].isFavorite ?? false) {
            cell?.statusImage.image = UIImage(named: "favorite")
        } else {
            cell?.statusImage.image = UIImage(named: "no_favorite")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = self.posts else { return 0 }
        return posts.count
    }
    
}
