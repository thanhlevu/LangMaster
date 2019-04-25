//
//  CourseBriefViewController.swift
//  LangMaster
//
//  Created by Thath on 25/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class CourseBriefViewController: UIViewController {

    var titleBrief:String = ""
    var subTitleBrief:String = ""
    var linkToImageBrief:String = "https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let url = NSURL(string: linkToImageBrief)
//        if let data = NSData(contentsOf: url! as URL) {
//            imageView.contentMode = UIView.ContentMode.scaleAspectFit
//            imageView.image = UIImage(data: data as Data)
//        }
        titleLabel.text = titleBrief
        subTitleLabel.text = subTitleBrief
        if let imageURL = URL(string: "https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg") {
            let data = try? Data(contentsOf: imageURL)
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView?.image = image
                    self.reloadInputViews()
                }
            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
