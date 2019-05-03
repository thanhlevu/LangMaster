//
//  CheckSkillTableViewCell.swift
//  LangMaster
//
//  Created by Thath on 02/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class CheckSkillTableViewCell: UITableViewCell {
    @IBOutlet var languageLevelLabel: UILabel!
    @IBOutlet var checkBoxLabel: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var courseView: UIView!
    
    @IBAction func checkboxClicked(_ sender: Any) {
//        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
//            (sender as AnyObject).transform = CGAffineTransform(scaleX:0.1, scaleY:0.1)
//            (sender as AnyObject).isSelected = !sender.isSelected
//        }) { (success) in
//            
//        }
    }
    @IBAction func searchButtonClicked(_ sender: Any) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
