//
//  DataFetcher.swift
//  LangMaster
//
//  Created by Thath on 03/05/2019.
//  Copyright © 2019 Thath. All rights reserved.
//

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

