//
//  ViewController2.swift
//  LangMaster
//
//  Created by Thath on 20/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navigationBar: UINavigationItem!

    @IBOutlet var bookmarkTableView: UITableView!
    
    
    @IBOutlet var editButton: UIBarButtonItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(bookmarkCourses[indexPath.item].title)
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarkTableViewCell
        let url = NSURL(string: bookmarkCourses[indexPath.item].linkToImage)
        if let data = NSData(contentsOf: url! as URL) {
            print(bookmarkCourses.count)
            cell.courseImageView.contentMode = UIView.ContentMode.scaleAspectFit
            cell.courseImageView.image = UIImage(data: data as Data)
            cell.courseTitleLabel.text = bookmarkCourses[indexPath.item].title
            cell.courseDescriptionLabel.text = bookmarkCourses[indexPath.item].description
            cell.courseAuthorLabel.text = bookmarkCourses[indexPath.item].author + " | " + bookmarkCourses[indexPath.item].updateTime
            cell.courseView.backgroundColor = cellBackgroundColor(cellIndex: indexPath.row, numberOfElements: bookmarkCourses.count)
            cell.courseView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.courseView.layer.borderWidth = 0.5
            cell.courseView.layer.cornerRadius = 12
        }
        return cell
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
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = cellBackgroundColor(cellIndex: indexPath.row, numberOfElements: bookmarkCourses.count)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        performSegue(withIdentifier: "bookmarkToWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?)
    {
        let svc = segue.destination as? WebPageViewController
        svc?.courseBrief = bookmarkCourses[0]
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookmarkCourseIdArray.remove(at: indexPath.row)
            bookmarkCourses.remove(at: indexPath.row)
            bookmarkTableView.reloadData()
        }
    }

    @IBAction func editBookmarks(_ sender: Any) {
        bookmarkTableView.isEditing = !bookmarkTableView.isEditing
        editButton.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        switch bookmarkTableView.isEditing {
        case true:
            editButton.title = "Done"
        default:
            editButton.title = "Edit"
        }
    }
    
    var bookmarkCourseIdArray = [1,2,3,4,5,6]
    var bookmarkCourses: [Courses] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        let userC = User();
        userC.setBookmarkArray([1])
        userC.setBookmarkArray(userC.bookmarkArray()+[2])
        //print(userC.bookmarkArray())
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInteractive).async {
            self.getJSONData()
        }
        // Do any additional setup after loading the view.
    }
    func getJSONData(){
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        guard let jsonDataURL = URL(string: "http://bit.ly/2XDl5T8") else {return}   // JSON data API
        session.dataTask(with: jsonDataURL) {(data, response, error) in
            do {
                let database = try JSONDecoder().decode(Database.self, from: data!)
                self.bookmarkCourses = (database.courseLevels.basicCourses + database.courseLevels.advancedCourses + database.courseLevels.frameworkCourses).filter {self.bookmarkCourseIdArray.contains($0.id)}
                DispatchQueue.main.async {
                    self.bookmarkTableView.reloadData()
                }
                print("???",self.bookmarkCourses[0])
            }
            catch {
                print(error)
            }
            }.resume()
    }
    
    
    func cellBackgroundColor( cellIndex: Int, numberOfElements: Int) -> UIColor {
        switch cellIndex + 1 {
        case 0...numberOfElements/3:
            return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case numberOfElements/3...2*numberOfElements/3:
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        default:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
    }
    
}
