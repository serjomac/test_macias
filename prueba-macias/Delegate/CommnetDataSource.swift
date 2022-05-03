//
//  CommnetDataSource.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import Foundation
import UIKit

class CommentDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - VARAIBLES
    var comments: [Comment]?
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "COMMENTS"
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentTableViewCell
        cell?.comment.text = comments?[indexPath.row].name
        return cell!
    }
    
            
}
