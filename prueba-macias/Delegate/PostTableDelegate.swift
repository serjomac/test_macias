//
//  PostTableDelegate.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import Foundation
import UIKit

protocol PostTableDelegateDelegate {
    func selectPostRow(post: Post)
    func deleteRow(post: Post)
}

class PostTableDelegate: NSObject, UITableViewDelegate {
    var posts: [Post]?
    var postDelegate: PostTableDelegateDelegate?
    var vc: UIViewController?
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        guard let post = posts?[section] else {
//            return 0.0
//        }
//        var height: CGFloat = 15
//        if let title = post.title {
//            height += self.getHeightOf(title: title, in: tableView)
//        }
//        return CGFloat(he ight)
//    }
    
//    private func getHeightOf(title: String?, in tableView: UITableView) -> CGFloat {
//        var heightOfContent: CGFloat = 0
//        if let text = title {
//            let widthOfContent = tableView.bounds.width
//            let font = UIFont.boldSystemFont(ofSize: 15)
//            heightOfContent = text.heightWithConstrainedWidth(width: CGFloat(widthOfContent), font: font) + 6
//        }
//
//        return heightOfContent
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        postDelegate?.deleteRow(post: posts![indexPath.row])
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postDelegate?.selectPostRow(post: posts![indexPath.row])
    }
}
