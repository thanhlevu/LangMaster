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
        return languageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "langCell", for: indexPath) as! LangCollectionViewCell
        cell.langLogoImageView.image = UIImage(named: languageArr[indexPath.item].logo)
        cell.langLogoImageView.setImageColor(color: .white)
        //cell.langLogoImageView.image.
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        cell.layer.cornerRadius = 60 //set corner radius here
        cell.layer.shadowRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowColor = UIColor.orange.cgColor
//        cell.layer.borderColor = UIColor.lightGray.cgColor  // set cell border color here
//        cell.layer.borderWidth = 10 // set border width here
        cell.alpha = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedLanguage = languageArr[indexPath.row]
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderColor = UIColor.red.cgColor
//        cell?.layer.borderWidth = 12
//        cell?.animateBorderWidth(toValue: 1, duration: 0.3)
//        cell?.animateBorderWidth(toValue: 5, duration: 0.3)
//        cell?.alpha = 1
        performSegue(withIdentifier: "ProfileToChecklistSkill", sender: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let svc = segue.destination as? SkillViewController
        svc?.language = selectedLanguage
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderColor = UIColor.lightGray.cgColor
//        cell?.layer.borderWidth = 1
//        cell?.animateBorderWidth(toValue: 0, duration: 0.3)
//        cell?.animateBorderWidth(toValue: 2, duration: 0.3)
//        cell?.alpha = 1
    }
    var selectedLanguage: Language!

    @IBOutlet var langCollectionView: UICollectionView!
    var languageArr: [Language] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let layout = self.langCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10,left: 10,bottom: 0,right: 10)
        DispatchQueue.global(qos: .userInteractive).async {
            let dataFetcher = DataFetcher()
            dataFetcher.getJSONData(databaseCompletionHandler: {jsonData, error in
                if let jsonData = jsonData {
                    self.languageArr = jsonData.languages
                    DispatchQueue.main.async {
                        self.langCollectionView.reloadData()
                    }
                }
            })
        }
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
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
