//
//  ViewController3.swift
//  LangMaster
//
//  Created by Thath on 23/04/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return langLogo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "langCell", for: indexPath) as! LangCollectionViewCell
        cell.langLogoImageView.image = UIImage(named: langLogo[indexPath.item].logo)
        cell.langLogoImageView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        cell.layer.cornerRadius = 10 //set corner radius here
        cell.layer.borderColor = UIColor.red.cgColor  // set cell border color here
        cell.layer.borderWidth = 2 // set border width here
        return cell
    }
    

    @IBOutlet var langCollectionView: UICollectionView!
    var langLogo: [LangLogo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
    }
    
    func getJSONData(){
        guard let jsonDataURL = URL(string: "https://thanhlevu.github.io/langcourses.json") else {return}   // JSON data API
        URLSession.shared.dataTask(with: jsonDataURL) {(data, response, error) in
            do {
                let database = try JSONDecoder().decode(Database.self, from: data!)
                print(database.languages)
                self.langLogo = database.languages
                DispatchQueue.main.async {
                    self.langCollectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
            }.resume()
    }
}
