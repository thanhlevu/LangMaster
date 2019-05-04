//
//  ViewController2.swift
//  LangMaster
//
//  Created by Thath on 20/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var bookmarkTableView: UITableView!
    var selectedCourse:Courses!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkCourses.count
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bookmarkTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarkTableViewCell
        let url = NSURL(string: bookmarkCourses[indexPath.item].linkToImage)
        if let data = NSData(contentsOf: url! as URL) {
            cell.courseImageView.contentMode = UIView.ContentMode.scaleAspectFit
            cell.courseImageView.image = UIImage(data: data as Data)
            cell.courseTitleLabel.text = bookmarkCourses[indexPath.item].title
            cell.courseDescriptionLabel.text = bookmarkCourses[indexPath.item].description
            cell.courseAuthorLabel.text = bookmarkCourses[indexPath.item].author + " | " + bookmarkCourses[indexPath.item].updateTime
            cell.courseView.backgroundColor = cellBackgroundColor(cellIndex: indexPath.row, numberOfElements: bookmarkCourses.count)
            cell.selectionStyle = .none
            cell.courseView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cell.courseView.layer.borderWidth = 1
            cell.courseView.layer.cornerRadius = 12
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        if !bookmarkTableView.isEditing {
            return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let idItem = bookmarkCourseIdArray[sourceIndexPath.row]
        let courseItem = bookmarkCourses[sourceIndexPath.row]
        bookmarkCourseIdArray.remove(at: sourceIndexPath.row)
        bookmarkCourses.remove(at: sourceIndexPath.row)
        bookmarkCourseIdArray.insert(idItem, at: destinationIndexPath.row)
        bookmarkCourses.insert(courseItem, at: destinationIndexPath.row)
        bookmarkTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
//        selectedCell.backgroundColor = cellBackgroundColor(cellIndex: indexPath.row, numberOfElements: bookmarkCourses.count)
//        selectedCell.contentView.backgroundColor = cellBackgroundColor(cellIndex: indexPath.row, numberOfElements: bookmarkCourses.count)
        selectedCourse = bookmarkCourses[indexPath.row]
        performSegue(withIdentifier: "bookmarkToWeb", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?)
    {
        let svc = segue.destination as? WebPageViewController
        svc?.courseBrief = selectedCourse
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookmarkCourseIdArray.remove(at: indexPath.row)
            bookmarkCourses.remove(at: indexPath.row)
            bookmarkTableView.reloadData()
        }
    }
    
    @IBOutlet var editButton: UIBarButtonItem!
    @IBAction func editBookmarks(_ sender: Any) {
        bookmarkTableView.isEditing = !bookmarkTableView.isEditing
        switch bookmarkTableView.isEditing {
        case true:
            editButton.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            editButton.title = "Done"
        default:
            editButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            editButton.title = "Edit"
        }
    }
    
    var bookmarkCourseIdArray = [1,2,3,4,5,6]
    var bookmarkCourses: [Courses] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bookmarkTableView.separatorStyle = .none
        // Hide the Navigation Bar
        let userC = User();
        userC.setBookmarkArray([1])
        userC.setBookmarkArray(userC.bookmarkArray()+[2])
        //print(userC.bookmarkArray())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        DispatchQueue.global(qos: .userInteractive).async {
            let dataFetcher = DataFetcher()
            dataFetcher.getJSONData(databaseCompletionHandler: {jsonData, error in
                if let jsonData = jsonData {
                    self.bookmarkCourses = (jsonData.courseLevels.basicCourses + jsonData.courseLevels.advancedCourses + jsonData.courseLevels.frameworkCourses).filter {self.bookmarkCourseIdArray.contains($0.id)}
                    DispatchQueue.main.async {
                        self.bookmarkTableView.reloadData()
                        
                    }
                }
            })
        }
    }    
    
    func cellBackgroundColor( cellIndex: Int, numberOfElements: Int) -> UIColor {
        self.tabBarController?.tabBar.items?[1].badgeValue = String(self.bookmarkCourses.count)
        switch Double(cellIndex)/Double(numberOfElements) {
        case 0..<1/3:
            return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case (1/3)..<(2/3):
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        default:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
    }
    
}
