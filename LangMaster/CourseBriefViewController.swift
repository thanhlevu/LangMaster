//
//  CourseBriefViewController.swift
//  LangMaster
//
//  Created by Thath on 25/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class CourseBriefViewController: UIViewController {

    var courseBrief: Courses!
//    var titleBrief:String = ""
//    var subTitleBrief:String = ""
//    var linkToImageBrief:String = "https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg"


    

    @IBOutlet var imageView: UIImageView!
    @objc func tapButton(){
        print("added to bookmatks")
    }

    @IBAction func goToWebPage(_ sender: Any) {
        print("Go To Web Page")
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var starLable: UILabel!
    @IBOutlet var enrolledLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var publishTimeLable: UILabel!
    @IBOutlet var authorLabel: UILabel!         // the connection will unvalid if change the name E.g: authorLabel ==> anyName
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var originPriceLabel: UILabel!
    
    override func viewDidLoad() {
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = courseBrief?.name.capitalized
        titleLabel.text = courseBrief.title

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        subtitleLabel.text = courseBrief?.subtitle ?? ""
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        ratingLabel.text = courseBrief.ratings
        starLable.text = courseBrief.stars
        priceLabel.text = "€"+courseBrief.price
        enrolledLabel.text = courseBrief.studentN
        hourLabel.text = courseBrief.studyHours
        publishTimeLable.text = courseBrief.updateTime
        authorLabel.text = courseBrief.author

        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: " €"+courseBrief.originPrice+" ")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        originPriceLabel.attributedText = attributeString
        UIFont.boldSystemFont(ofSize: 16.0)
        let addButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(tapButton))
        self.navigationItem.rightBarButtonItem = addButton
        
        let url = NSURL(string: courseBrief?.linkToImage ?? "")
        if let data = NSData(contentsOf: url! as URL) {
            imageView.image = UIImage(data: data as Data)
        }
    }
    
}



