//
//  CommentTableDelegate.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import Foundation
import UIKit

class CommentTableDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .gray
        // For Header Text Color
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
}
