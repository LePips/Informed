//
//  News.swift
//  Informed
//
//  Created by Ethan Pippin on 2/27/19.
//  Copyright © 2019 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

private let apiKey = "407b28693a1a4b9b804c679db6982aee"
private var baseUrl = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
private let countryParam = ["country": "us"]

struct News {
    static func getFor(_ keyword: String, completion: @escaping ([Article]) -> ()) {
        let params = ["q": keyword, "sortBy": "publishedAt", "country": "us"]
        let headers: Headers = ["x-api-key": apiKey]
        Internet.GET(url: baseUrl.url!, params: params, headers: headers) { (response) in
            if let error = response.error {
                print(error)
                return
            }
            if let value = response.value {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let key = value.json["articles"] as! [JSON]
                    let articleData = try JSONSerialization.data(withJSONObject: key, options: .prettyPrinted)
                    let articles = try decoder.decode([Article].self, from: articleData)
                    completion(articles)
                } catch {
                    return
                }
            }
        }
    }
}

extension URLComponents {
    mutating func addSearch(_ keyword: String) {
        let component = URLQueryItem(name: "q", value: keyword)
        self.queryItems?.append(component)
    }
}
