//
//  DataFetcher.swift
//  LangMaster
//
//  Created by Thath on 03/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

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
    let whatToLearn: String
    let description: String
    let studentN: String
    let author: String
    let studyHours: String
    let updateTime:String
}
struct CourseLevels: Codable {
    let basicCourses: [Courses]
    let advancedCourses: [Courses]
    let frameworkCourses: [Courses]
}
struct Language: Codable {
    let name: String
    let logo: String
    var frameworks: [String]
}
struct Database: Codable {
    let courseLevels: CourseLevels
    let languages: [Language]
}

import Foundation
class DataFetcher {
    func getJSONData(databaseCompletionHandler: @escaping (Database?, Error?) -> Void) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        guard let jsonDataURL = URL(string: "http://bit.ly/2XDl5T8") else { return }
        
        session.dataTask(with: jsonDataURL, completionHandler: {data, response, error in
            do {
                let jsonData = try JSONDecoder().decode(Database.self ,from: data!)
                databaseCompletionHandler(jsonData, nil)
            } catch let parseErr {
                print(parseErr)
                databaseCompletionHandler(nil, parseErr)
            }
        }).resume()
    }
}

