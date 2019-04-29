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
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell")
        cell?.textLabel?.text = bookmarkCourses[indexPath.item].title
        cell?.backgroundColor = cellBackgroundColor(cellIndex: indexPath.row, numberOfElements: bookmarkCourses.count)
        return cell!
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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(bookmarkCourseIdArray[indexPath.row])
        print(bookmarkCourses[indexPath.row])
        performSegue(withIdentifier: "bookmarkToWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        let svc = segue.destination as? WebPageViewController
//        svc?.courseBrief = sender
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
    
    var bookmarkCourseIdArray = [1,2,3,4,5,6,7,8]
    var bookmarkCourses: [Courses] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
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
                print(self.bookmarkCourses.count)
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
