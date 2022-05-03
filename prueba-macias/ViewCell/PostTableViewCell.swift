//
//  PostViewCellTableViewCell.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 1/5/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - OULETS
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
//        postTitle.sizeToFit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
