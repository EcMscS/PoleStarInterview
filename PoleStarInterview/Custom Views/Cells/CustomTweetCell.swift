//
//  CustomTweetCell.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 04/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import UIKit

class CustomTweetCell: UITableViewCell {
    
    static let reuseID = "TweetCell"
    
    let containerView = UIView()
    let avatarImageView = CustomImageView(frame: .zero)
    let nameLabel = UILabel()
    let tweetLabel = UILabel()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(tweetsFor: TwitterHandle) {
        avatarImageView.downloadImage(from: tweetsFor.user.profile_image_url)
        nameLabel.text = tweetsFor.user.name
        tweetLabel.text = tweetsFor.text
    }
    
    
    private func configureContainerView() {
        addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .tertiarySystemBackground
        
        if traitCollection.userInterfaceStyle == .light {
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = CGSize.zero
            containerView.layer.shadowRadius = 15
            containerView.layer.shadowOpacity = 0.9
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
    }
}
