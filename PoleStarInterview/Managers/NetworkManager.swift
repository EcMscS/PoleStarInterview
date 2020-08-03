//
//  NetworkManager.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 03/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
    
    private init() {}
    
    func getTwitterFeed(for username: String, numberOfTweets: Int, completed: @escaping (Result<[TwitterHandle], CustomError>) -> Void) {
        let endpoint = baseURL + "\(username)&count=\(numberOfTweets)"
        var request = URLRequest(url: URL(string: "\(endpoint)")!)
        request.addValue("Bearer \(Authentication.bearerToken)", forHTTPHeaderField: "Authorization")
        
        
        guard URL(string: endpoint) != nil else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tweets = try decoder.decode([TwitterHandle].self, from: data)
                completed(.success(tweets))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
