//
//  Fetcher.swift
//  LangMaster
//
//  Created by Thath on 02/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

import Foundation
class DataFetcher {
    var db: Database?
    func getJSONData() -> Database?{
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        guard let jsonDataURL = URL(string: "http://bit.ly/2XDl5T8") else {
            print("Wrong url")
            return nil
        }
        session.dataTask(with: jsonDataURL) {(data, response, error) in
            do {
                let database = try JSONDecoder().decode(Database.self ,from: data!)
                self.db = database
                print(self.db!)
            }
            catch {
                print(error)
            }
            }.resume()
        return self.db
    }
}

