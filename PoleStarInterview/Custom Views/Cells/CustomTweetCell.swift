//
//  CustomTweetCell.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 04/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import UIKit

class CustomTweetCell: UITableViewCell {

    let containerView = UIView()
    let avatarImageView = CustomImageView(frame: .zero)
    let nameLabel = UILabel()
    let handleLabel = UILabel()
    let likeCounterLabel = UILabel()
    let retweetCounterLabel = UILabel()
    let tweetLabel = UILabel()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    func set(data: [TwitterHandle]) {
        for tweet in data {
            avatarImageView.downloadImage(from: tweet.user.profile_image_url)
            nameLabel.text = tweet.user.name
            handleLabel.text = "@\(tweet.user.screen_name)"
            likeCounterLabel.text = "♥️ \(tweet.favorite_count)"
            tweetLabel.text = tweet.text
        }
    }
    
    
    func configureUI() {
        configureContainerView()
        configureAvatarImageView()
        configureNameLabel()
        configureHandleLabel()
        configureLikeCounterLabel()
        configureTweetLabel()
    }

    
    func configureContainerView() {
        self.contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 17
        containerView.backgroundColor = .tertiarySystemBackground
        
        if traitCollection.userInterfaceStyle == .light {
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = CGSize.zero
            containerView.layer.shadowRadius = 10
            containerView.layer.shadowOpacity = 0.4
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    
    func configureAvatarImageView() {
        containerView.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func configureNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.numberOfLines = 1
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.clipsToBounds = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    func configureHandleLabel() {
        containerView.addSubview(handleLabel)
        handleLabel.numberOfLines = 1
        handleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        handleLabel.textColor = .secondaryLabel
        handleLabel.clipsToBounds = false
        handleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            handleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            handleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            handleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            handleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    func configureLikeCounterLabel() {
        containerView.addSubview(likeCounterLabel)
        likeCounterLabel.textAlignment = .right
        likeCounterLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeCounterLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            likeCounterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            likeCounterLabel.heightAnchor.constraint(equalToConstant: 20),
            likeCounterLabel.widthAnchor.constraint(equalToConstant: 80)
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
