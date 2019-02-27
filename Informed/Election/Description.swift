//
//  Description.swift
//  Informed
//
//  Created by Ethan Pippin on 9/18/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

struct Description: Codable {
    var url: String? = nil
    var reference: String? = nil
    
    func description() -> String? {
        let group = DispatchGroup()
        group.enter()
        guard let urlString = url else { return nil }
        let this = URL(string: urlString)!
        var returnThis: String = ""
        
        Internet.GET(url: this) { response in
            let json = response.value?.json
            
            let query = json?["query"] as! JSON
            let pages = query["pages"] as! JSON
            let value = pages.first?.value as! JSON
            returnThis = value["extract"] as! String
            
            group.leave()
        }
        
        group.wait()
        return returnThis
    }
    
    init(_ url: String?, _ reference: String?) {
        self.url = url
        self.reference = reference
    }
}

struct Info: Codable {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    static func nothing() -> Info {
        return Info(title: "Nothing", content: "No content fo u")
    }
}
