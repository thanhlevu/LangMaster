//
//  BookmarkTableViewCell.swift
//  LangMaster
//
//  Created by Thath on 29/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {

    @IBOutlet var courseImageView: UIImageView!
    @IBOutlet var courseTitleLabel: UILabel!
    @IBOutlet var courseDescriptionLabel: UILabel!
    @IBOutlet var courseView: UIView!
    
    @IBOutlet var courseAuthorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
