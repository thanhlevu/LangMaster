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
        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
        cell.layer.borderWidth = 2 // set border width here
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.red.cgColor
        cell?.layer.borderWidth = 5
        cell?.animateBorderWidth(toValue: 1, duration: 0.3)
        cell?.animateBorderWidth(toValue: 5, duration: 0.3)

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 2
        cell?.animateBorderWidth(toValue: 0, duration: 0.3)
        cell?.animateBorderWidth(toValue: 2, duration: 0.3)
        cell?.alpha = 0.5
    }
    
    @IBOutlet var langCollectionView: UICollectionView!
    var langLogo: [LangLogo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = self.langCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10)
        layout.minimumLineSpacing = 20
        //layout.itemSize = CGSize(width: (self.langCollectionView.frame.size.width - 20)/2, height: (self.langCollectionView.frame.size.height)/3)
        getJSONData()
    }
    
    func getJSONData(){
        guard let jsonDataURL = URL(string: "http://bit.ly/2XDl5T8") else {return}   // JSON data API
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
extension UIView {
    func animateBorderWidth(toValue: CGFloat, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
    }
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}
