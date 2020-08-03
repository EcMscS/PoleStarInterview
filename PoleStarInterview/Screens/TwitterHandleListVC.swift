//
//  TwitterHandleListVC.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 03/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import UIKit

class TwitterHandleListVC: UIViewController {

    var username: String!
    var tweets = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getTweets(username: username, tweets: tweets)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    func getTweets(username: String, tweets: Int) {
        showLoadingView()
        NetworkManager.shared.getTwitterFeed(for: username, numberOfTweets: tweets) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let tweets):
                print("TWEETS: \(tweets)")
                
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
}
