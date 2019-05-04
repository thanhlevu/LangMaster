//
//  CourseLevelTableViewCell.swift
//  LangMaster
//
//  Created by Thath on 20/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class CourseLevelTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionViewOutlet: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func reloadData() {
        collectionViewOutlet.reloadData()
    }

}
