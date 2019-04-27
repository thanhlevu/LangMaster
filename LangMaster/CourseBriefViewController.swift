//
//  CourseBriefViewController.swift
//  LangMaster
//
//  Created by Thath on 25/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit
import UserNotifications

class CourseBriefViewController: UIViewController {

    var courseBrief: Courses!
    
    @IBOutlet var imageView: UIImageView!
    

    @IBAction func goToWeb(_ sender: Any) {
        performSegue(withIdentifier: "BriefToWeb", sender: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let svc = segue.destination as? WebPageViewController
        svc?.courseBrief = courseBrief
    }
    
    @objc func tapBookMarkButton(){
        //Set up a notification
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = courseBrief.title
        content.subtitle = courseBrief.subtitle
        content.body = "Added this course into your bookmarks"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "thread"
        let date = Date(timeIntervalSinceNow: 1)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        center.add(request) {(error) in
            if error != nil {
                print(error!)
            }
        }
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
        
        let url = NSURL(string: courseBrief?.linkToImage ?? "")
        if let data = NSData(contentsOf: url! as URL) {
            imageView.image = UIImage(data: data as Data)
        }
        
        self.title = courseBrief?.name.capitalized
        titleLabel.text = courseBrief.title

        titleLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        subtitleLabel.text = courseBrief?.subtitle ?? ""
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        ratingLabel.setTextWithIconImage(image: UIImage(named: "Ratings")!, with: courseBrief.ratings)
        starLable.setTextWithIconImage(image: UIImage(named: "Star")!, with: courseBrief.stars)
        priceLabel.setTextWithIconImage(image: UIImage(named: "Price")!, with: "€"+courseBrief.price)
        enrolledLabel.setTextWithIconImage(image: UIImage(named: "EnrolledN")!, with: courseBrief.studentN)
        hourLabel.setTextWithIconImage(image: UIImage(named: "StudyTime")!, with: courseBrief.studyHours)
        publishTimeLable.setTextWithIconImage(image: UIImage(named: "UpdateTime")!, with: courseBrief.updateTime)
        authorLabel.setTextWithIconImage(image: UIImage(named: "Author")!, with: "Created by "+courseBrief.author)
        originPriceLabel.setTextWithIconImage(image: UIImage(named: "Price")!, with: "€"+courseBrief.originPrice)

        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: " €"+courseBrief.originPrice+" ")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        originPriceLabel.attributedText = attributeString
        UIFont.boldSystemFont(ofSize: 16.0)
        
        //create add Button on Navigation Bar
        let bookmarkButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(tapBookMarkButton))
        self.navigationItem.rightBarButtonItem = bookmarkButton
        

    }
    

    
}
extension UILabel {
    
    func setTextWithIconImage(image: UIImage, with text: String) {
        let text2 = " " + text + "    "
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageOffsetY:CGFloat = -2.0;
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: image.size.width - 8, height: image.size.height - 8)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)
        
        let textString = NSAttributedString(string: text2, attributes: [.font: self.font])
        mutableAttributedString.append(textString)
        
        self.attributedText = mutableAttributedString
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.textAlignment = .center
    }
}


