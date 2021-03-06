//
//  StudyPathViewController.swift
//  LangMaster
//
//  Created by Thath on 01/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileCellSubclassDelegate {
 
    @IBOutlet var tableView: UITableView!
    var language: Language?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        language?.frameworks.insert(contentsOf: ["Basic","Advanced"], at: 0)
        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language?.frameworks.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistSkill", for: indexPath) as! CheckSkillTableViewCell
        cell.languageLevelLabel.text = language!.frameworks[indexPath.row]
        cell.languageLevelLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell.languageLevelLabel.textColor = .white
        //cell.courseView.setGradientBackground(colorTop: #colorLiteral(red: 0.6076138648, green: 1, blue: 0.4611086114, alpha: 1), colorBottom: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
        switch language?.frameworks[indexPath.row].lowercased() {
        case "basic":
            cell.courseView.layer.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case "advanced":
            cell.courseView.layer.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        default:
            cell.courseView.layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        cell.courseView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.courseView.layer.borderWidth = 0.5
        cell.courseView.layer.cornerRadius = 12
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }

    func searchButtonTapped(cell: CheckSkillTableViewCell, sender: UIButton) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        selectedCellIndex = indexPath.row
        self.tabBarController?.selectedIndex = 0
        let tabBar = tabBarController as! BaseTabBarController
        switch language?.frameworks[selectedCellIndex].lowercased() {
        case "basic":
            tabBar.searchingKeyword = language!.name + "-1"
        case "advanced":
            tabBar.searchingKeyword = language!.name + "-2"
        default:
            tabBar.searchingKeyword = language!.frameworks[selectedCellIndex].lowercased()
        }
    }
    
    var selectedCellIndex = 0
    
    func checkBoxTapped(cell: CheckSkillTableViewCell, sender: UIButton) {
        guard self.tableView.indexPath(for: cell) != nil else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlDown, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            sender.isSelected = !sender.isSelected
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlDown, animations: {
                sender.transform = .identity
            }, completion: nil)
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
extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
