//
//  ViewController.swift
//  LangMaster
//
//  Created by Thath on 19/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

struct Courses: Codable {
    let id: Int
    let name: String
    let no: String
    let title: String
    let subtitle: String
    let linkToWeb: String
    let linkToImage: String
    let requirements: [String]
    let stars: String
    let ratings: String
    let price: String
    let originPrice: String
}
struct CourseLevels: Codable {
    let basicCourses: [Courses]
    let advancedCourses: [Courses]
    let frameworkCourses: [Courses]
}
struct Database: Codable {
    let courseLevels: CourseLevels
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var basicCourseArr = [Courses]()
    var advancedCourseArr = [Courses]()
    var frameworkCourseArr = [Courses]()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = UIColor.orange
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UITabBar.appearance().barTintColor = UIColor.orange // your color
        UITabBar.appearance().tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) // your color
    }
    
    
    func getJSONData(){
        guard let jsonDataURL = URL(string: "http://bit.ly/2Gv9rTl") else {return}
        URLSession.shared.dataTask(with: jsonDataURL) {(data, response, error) in
            do {
                let database = try JSONDecoder().decode(Database.self, from: data!)
                self.basicCourseArr = database.courseLevels.basicCourses
                self.advancedCourseArr = database.courseLevels.advancedCourses
                self.frameworkCourseArr = database.courseLevels.frameworkCourses
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error)
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellY", for: indexPath) as? CourseLevelTableViewCell else {return UITableViewCell()}
        cell.collectionViewOutlet.tag = indexPath.section ///
        cell.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        returnedView.backgroundColor = .lightGray
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        switch section {
        case 0:
            label.text = NSLocalizedString("    Basic Courses", comment: "Basic Courses")
        case 1:
            label.text = NSLocalizedString("    Advanced Courses", comment: "Advanced Courses")
        default:
            label.text = "    Framework Courses"
        }
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        label.textAlignment = .left;
        returnedView.addSubview(label)
        return returnedView
    }
    
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return self.basicCourseArr.count
        } else if collectionView.tag == 1 {
            return self.advancedCourseArr.count
        } else {
            return self.frameworkCourseArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellX", for: indexPath) as! CourseCollectionViewCell
        if collectionView.tag == 0 {
            if !basicCourseArr.isEmpty {
                let url = NSURL(string: basicCourseArr[indexPath.item].linkToImage)
                if let data = NSData(contentsOf: url! as URL) {
                    cell.imageView.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.imageView.image = UIImage(data: data as Data)
                    cell.titleLable.text = basicCourseArr[indexPath.item].title
                    cell.priceLable.text = "€ "+basicCourseArr[indexPath.item].price
                    cell.ratingView.rating = Double(basicCourseArr[indexPath.item].ratings) ?? 1.0
                    cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                }
            }
        } else if collectionView.tag == 1 {
            if !advancedCourseArr.isEmpty {
                let url = NSURL(string: advancedCourseArr[indexPath.item].linkToImage)
                if let data = NSData(contentsOf: url! as URL) {
                    cell.imageView.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.imageView.image = UIImage(data: data as Data)
                    cell.titleLable.text = advancedCourseArr[indexPath.item].title
                    cell.priceLable.text = "€ "+advancedCourseArr[indexPath.item].price
                    cell.ratingView.rating = Double(advancedCourseArr[indexPath.item].ratings) ?? 1.0
                    cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                }
            }
        } else {
            if !frameworkCourseArr.isEmpty {
                let url = NSURL(string: frameworkCourseArr[indexPath.item].linkToImage)
                if let data = NSData(contentsOf: url! as URL) {
                    cell.imageView.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.imageView.image = UIImage(data: data as Data)
                    cell.titleLable.text = frameworkCourseArr[indexPath.item].title
                    cell.priceLable.text = "€ "+frameworkCourseArr[indexPath.item].price
                    cell.ratingView.rating = Double(frameworkCourseArr[indexPath.item].ratings) ?? 1.0
                    cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                }
            }
        }

        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
