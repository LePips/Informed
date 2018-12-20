//
//  Firenet.swift
//  Informed
//
//  Created by Ethan Pippin on 9/13/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation

struct Firenet {
    
    static var announcements: URL {
        let path = ["announcements"]
        return buildURL(pathComponents: path)
    }
    
    static var elections: URL {
        let path = ["elections"]
        return buildURL(pathComponents: path)
    }
    
    static var featuredElection: URL {
        let path = ["featured_election"]
        return buildURL(pathComponents: path)
    }
    
    static var candidates: URL {
        let path = ["candidates"]
        return buildURL(pathComponents: path)
    }
    
    fileprivate static var baseURL: URL {
        return URL(string: "pippin-informed.firebaseio.com")!
    }
    
    fileprivate static func buildURL(pathComponents: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL.absoluteString
        if !pathComponents.isEmpty {
            components.path = "/" + pathComponents.joined(separator: "/") + ".json"
        }
        guard let url = components.url else {
            fatalError("Unable to build url with components: \(pathComponents)")
        }
        return url
    }
}
