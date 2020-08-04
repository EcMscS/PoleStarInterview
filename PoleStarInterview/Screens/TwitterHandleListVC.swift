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
        getTweets(username: username, tweets: tweets)
        configureViewController()
        
        configureContainerView()
        configureAvatarImageView()
        configureNameLabel()
        configureTweetLabel()
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
                
                DispatchQueue.main.async {
                    self.nameLabel.text = tweets[0].user.name
                    self.tweetLabel.text = tweets[0].text
                    self.avatarImageView.downloadImage(from: tweets[0].user.profile_image_url)
                }
                
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    //BREAK
    
    let containerView = UIView()
    let avatarImageView = CustomImageView(frame: .zero)
    let nameLabel = UILabel()
    let tweetLabel = UILabel()
    
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 7.5
        containerView.layer.shadowOpacity = 0.2
        containerView.backgroundColor = .systemBlue
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
    }
    
    
    func configureAvatarImageView() {
        containerView.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configureNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.clipsToBounds = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    func configureTweetLabel() {
        containerView.addSubview(tweetLabel)
        tweetLabel.numberOfLines = 0
        tweetLabel.adjustsFontSizeToFitWidth = true
        tweetLabel.clipsToBounds = false
        tweetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tweetLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            tweetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            tweetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            tweetLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
        ])
    }
}
