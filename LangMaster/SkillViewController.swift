//
//  StudyPathViewController.swift
//  LangMaster
//
//  Created by Thath on 01/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var language: Language?
    override func viewDidLoad() {
        super.viewDidLoad()
        language?.frameworks.insert(contentsOf: ["Basic","Advanced"], at: 0)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language?.frameworks.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistSkill", for: indexPath) as! CheckSkillTableViewCell
        cell.languageLevelLabel.text = language?.frameworks[indexPath.row].capitalized ?? "Nil"
        return cell
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
