//
//  APIProvider.swift
//  RxSwiftTest
//
//  Created by Maxim Spiridonov on 19/04/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation
import RxSwift

class APIProvider {
    func getRepositories(_ gitHubID: String) -> Observable<[Repository]> {
        guard !gitHubID.isEmpty,
            let url = URL(string: "https://api.github.com/users/\(gitHubID)/repos")
            else { return Observable.just([]) }
        
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .retry(3)
            .map {
                var repositories = [Repository]()
                if let items = $0 as? [[String : AnyObject]] {
                    items.forEach {
                        guard
                            let name = $0["name"] as? String,
                            let url = $0["html_url"] as? String
                        else { return }
                        repositories.append(Repository(name: name, url: url))
                        
                    }
                }
                return repositories
            }
    }
}
