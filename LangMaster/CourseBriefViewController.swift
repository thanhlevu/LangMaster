//
//  CourseBriefViewController.swift
//  LangMaster
//
//  Created by Thath on 25/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class CourseBriefViewController: UIViewController {

    var courseBrief: Courses?
    var titleBrief:String = ""
    var subTitleBrief:String = ""
    var linkToImageBrief:String = "https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg"
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!

    
    @IBAction func goToWebPage(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = courseBrief?.name.capitalized
        
        super.viewDidLoad()
        titleLabel.text = courseBrief?.title ?? ""
        subTitleLabel.text = courseBrief?.subtitle ?? ""
        
        let url = NSURL(string: courseBrief?.linkToImage ?? "")
        if let data = NSData(contentsOf: url! as URL) {
            //imageView.contentMode = UIView.ContentMode.scaleAspectFit   // get the image origin size
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.image = UIImage(data: data as Data)
        }
    }
    
}



