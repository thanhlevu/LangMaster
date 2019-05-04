//
//  WebPageViewController.swift
//  LangMaster
//
//  Created by Thath on 27/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit
import WebKit
import UserNotifications

class WebPageViewController: UIViewController {

    var courseBrief: Courses!
    
    @IBOutlet var web: WKWebView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue.global()
        queue.async {
            if self.courseBrief.linkToWeb != "" {
                let request = URLRequest(url: URL(string: self.courseBrief.linkToWeb)!)
                DispatchQueue.main.async {
                    self.web.load(request)
                }
            }
        }
        
        //create add Button on Navigation Bar
        let bookmarkButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(tapBookMarkButton))
        self.navigationItem.rightBarButtonItem = bookmarkButton
        // Do any additional setup after loading the view.
        


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
