//
//  ViewController.swift
//  LangMaster
//
//  Created by Thath on 19/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!

   // var courseDatabase = CourseLevels() = {}
    var basicCourseArr = [Courses]()
    var advancedCourseArr = [Courses]()
    var frameworkCourseArr = [Courses]()
    
    var isSearching: Bool = false
    var searchBasicCourseArr = [Courses]()
    var searchAdvancedCourseArr = [Courses]()
    var searchFrameWorkCourseArr = [Courses]()

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var selectedCourse:Courses!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        let userC = User();
        userC.setBookmarkArray([1])
        userC.setBookmarkArray(userC.bookmarkArray()+[2])
        //print(userC.bookmarkArray())

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //self.tabBarController?.tabBar.items?[1].badgeValue = "5"
        self.hideKeyboardWhenTappedAround()          // hide the keyboard when tapping around
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.7422073287, green: 0.4305739439, blue: 0.009549473904, alpha: 1)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let dataFetcher = DataFetcher()
            dataFetcher.getJSONData(databaseCompletionHandler: {jsonData, error in
                if let jsonData = jsonData {
                    self.courseDatabase = jsonData
                    self.basicCourseArr = self.courseDatabase.courseLevels.basicCourses
                    self.advancedCourseArr = self.courseDatabase.courseLevels.advancedCourses
                    self.frameworkCourseArr = self.courseDatabase.courseLevels.frameworkCourses
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        print("courseDatabase", self.courseDatabase)
                    }
                }
            })
        }
        searchBar.barTintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.tabBarController?.tabBar.tintColor = UIColor.white
        self.tabBarController?.tabBar.barTintColor = UIColor.orange
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            searchBasicCourseArr = basicCourseArr.filter { $0.title.lowercased().contains((searchBar.text!.lowercased())) || $0.no.lowercased().contains((searchBar.text!.lowercased())) || $0.name.lowercased().contains((searchBar.text!.lowercased())) }
            searchAdvancedCourseArr = advancedCourseArr.filter { $0.title.lowercased().contains((searchBar.text!.lowercased())) || $0.no.lowercased().contains((searchBar.text!.lowercased())) || $0.name.lowercased().contains((searchBar.text!.lowercased())) }
            searchFrameWorkCourseArr = frameworkCourseArr.filter { $0.title.lowercased().contains((searchBar.text!.lowercased())) || $0.no.lowercased().contains((searchBar.text!.lowercased())) || $0.name.lowercased().contains((searchBar.text!.lowercased())) }
            self.tableView.reloadData()
        }
    }
    
    //hide the Keyboard when scrolling or clicking on Search Button
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    

    var courseDatabase:Database!
    
    func getJSONData(){
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        guard let jsonDataURL = URL(string: "http://bit.ly/2XDl5T8") else {return}   // JSON data API
        session.dataTask(with: jsonDataURL) {(data, response, error) in
            do {
                let database = try JSONDecoder().decode(Database.self, from: data!)
                self.courseDatabase = database
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
        switch section {
        case 0:
            if isSearching && searchBasicCourseArr.count == 0 {
                return searchBasicCourseArr.count
            } else {
                return 1
            }
        case 1:
            if isSearching && searchAdvancedCourseArr.count == 0 {
                return searchAdvancedCourseArr.count
            } else {
                return 1
            }
        default:
            if isSearching && searchFrameWorkCourseArr.count == 0 {
                return searchFrameWorkCourseArr.count
            } else {
                return 1
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellY", for: indexPath) as? CourseLevelTableViewCell
        cell!.collectionViewOutlet.tag = indexPath.section ///
        cell!.reloadData()
        
        return cell!
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
    func setupCell(cell: CourseCollectionViewCell, courseArr: [Courses], index: Int) {
        let url = NSURL(string: courseArr[index].linkToImage)
        if let data = NSData(contentsOf: url! as URL) {
            cell.imageView.contentMode = UIView.ContentMode.scaleAspectFit
            cell.imageView.image = UIImage(data: data as Data)
            cell.titleLable.text = courseArr[index].title
            cell.priceLable.text = "€ "+courseArr[index].price
            cell.ratingView.rating = Double(courseArr[index].ratings) ?? 1.0
            cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            if collectionView.tag == 0 {
                return self.searchBasicCourseArr.count
            } else if collectionView.tag == 1 {
                return self.searchAdvancedCourseArr.count
            } else {
                return self.searchFrameWorkCourseArr.count
            }
        } else {
            if collectionView.tag == 0 {
                return self.basicCourseArr.count
            } else if collectionView.tag == 1 {
                return self.advancedCourseArr.count
            } else {
                return self.frameworkCourseArr.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellX", for: indexPath) as! CourseCollectionViewCell
        if isSearching {
            if collectionView.tag == 0 {
                if !searchBasicCourseArr.isEmpty {
                    setupCell(cell: cell, courseArr: searchBasicCourseArr, index: indexPath.item)
                }
            } else if collectionView.tag == 1 {
                if !searchAdvancedCourseArr.isEmpty {
                    setupCell(cell: cell, courseArr: searchAdvancedCourseArr, index: indexPath.item)
                }
            } else {
                if !searchFrameWorkCourseArr.isEmpty {
                    setupCell(cell: cell, courseArr: searchFrameWorkCourseArr, index: indexPath.item)
                }
            }
        } else {
            if collectionView.tag == 0 {
                if !basicCourseArr.isEmpty {
                    setupCell(cell: cell, courseArr: basicCourseArr, index: indexPath.item)
                }
            } else if collectionView.tag == 1 {
                if !advancedCourseArr.isEmpty {
                    setupCell(cell: cell, courseArr: advancedCourseArr, index: indexPath.item)
                }
            } else {
                if !frameworkCourseArr.isEmpty {
                    setupCell(cell: cell, courseArr: frameworkCourseArr, index: indexPath.item)
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if isSearching {
            if collectionView.tag == 0 {
                selectedCourse = searchBasicCourseArr[indexPath.item]
            } else if collectionView.tag == 1 {
                selectedCourse = searchAdvancedCourseArr[indexPath.item]
            } else {
                selectedCourse = searchFrameWorkCourseArr[indexPath.item]
            }
        } else {
            if collectionView.tag == 0 {
                selectedCourse = courseDatabase.courseLevels.basicCourses[indexPath.item]
            } else if collectionView.tag == 1 {
                selectedCourse = courseDatabase.courseLevels.advancedCourses[indexPath.item]
            } else {
                selectedCourse = courseDatabase.courseLevels.frameworkCourses[indexPath.item]
            }
        }

        performSegue(withIdentifier: "homeToBriefV", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let svc = segue.destination as? CourseBriefViewController
        svc?.courseBrief = selectedCourse
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
