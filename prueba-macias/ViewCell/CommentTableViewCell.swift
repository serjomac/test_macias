//
//  ComentTableViewCell.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - OULETS
    @IBOutlet weak var comment: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
