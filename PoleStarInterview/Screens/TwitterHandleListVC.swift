//
//  TwitterHandleListVC.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 03/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import UIKit

class TwitterHandleListVC: UITableViewController {
    
    var username: String!
    var returnedTweets: [TwitterHandle] = []
    var numberOfTweets = 10
    var hasMoreTweets = true
    let reuseID = "TweetCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getTweets(username: username, numberOfTweets: numberOfTweets)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureTableView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(CustomTweetCell.self, forCellReuseIdentifier: reuseID)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnedTweets.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! CustomTweetCell
     
        let savedTweets = self.returnedTweets[indexPath.row]
        cell.set(data: [savedTweets])
        
        return cell
    }

    
    func getTweets(username: String, numberOfTweets: Int) {
        showLoadingView()
        NetworkManager.shared.getTwitterFeed(for: username, numberOfTweets: numberOfTweets) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let tweets):
                if tweets.count < 10 { self.hasMoreTweets = false }
                
                self.returnedTweets.removeAll()
                self.returnedTweets.append(contentsOf: tweets)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


extension TwitterHandleListVC: UICollectionViewDelegate {
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreTweets else { return }
            numberOfTweets += 10
            getTweets(username: username, numberOfTweets: numberOfTweets)
        }
    }
}
