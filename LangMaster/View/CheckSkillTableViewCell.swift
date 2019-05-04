//
//  CheckSkillTableViewCell.swift
//  LangMaster
//
//  Created by Thath on 02/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

protocol ProfileCellSubclassDelegate: class {
    func searchButtonTapped(cell: CheckSkillTableViewCell, sender: UIButton)
    func checkBoxTapped(cell: CheckSkillTableViewCell, sender: UIButton)
}

class CheckSkillTableViewCell: UITableViewCell {
    @IBOutlet var languageLevelLabel: UILabel!
    @IBOutlet var checkBoxLabel: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var courseView: UIView!
    
    weak var delegate: ProfileCellSubclassDelegate?
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        self.delegate?.searchButtonTapped(cell: self, sender: sender as! UIButton)
    }
    
    @IBAction func checkBoxClicked(_ sender: Any) {
        self.delegate?.checkBoxTapped(cell: self, sender: sender as! UIButton)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private lazy var gradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        return gradientLayer
    }()

}
