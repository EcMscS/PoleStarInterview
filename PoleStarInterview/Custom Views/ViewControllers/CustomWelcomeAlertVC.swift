//
//  CustomWelcomeAlertVC.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 06/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import UIKit

class CustomWelcomeAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let scrollViewContainer = UIView()
    let messageLabelContainer = UIScrollView()
    let actionButton = CustomButton(backgroundColor: .systemPink, title: "OK")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLayoutSubviews() {
        self.messageLabelContainer.contentSize = CGSize(width: 300, height: 1000)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureScrollViewContainer()
        configureMessageLabelContainer()
        configureMessageLabel()
    }
    
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .tertiarySystemBackground
        
        if traitCollection.userInterfaceStyle == .light {
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = CGSize.zero
            containerView.layer.shadowRadius = 15
            containerView.layer.shadowOpacity = 0.9
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Welcome"
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.9
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureScrollViewContainer() {
        containerView.addSubview(scrollViewContainer)
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40),
            scrollViewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            scrollViewContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            scrollViewContainer.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -50)
        ])
    }
    
    
    func configureMessageLabelContainer() {
        scrollViewContainer.addSubview(messageLabelContainer)
        messageLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabelContainer.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            messageLabelContainer.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            messageLabelContainer.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            messageLabelContainer.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -padding)
        ])
    }
    
    func configureMessageLabel() {
        messageLabelContainer.addSubview(messageLabel)
        messageLabel.text = message ?? "Welcome, I hope you enjoy the app!"
        
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.minimumScaleFactor = 0.75
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .label
        messageLabel.textAlignment = .left
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: messageLabelContainer.topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: messageLabelContainer.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: messageLabelContainer.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: messageLabelContainer.trailingAnchor),
            messageLabel.widthAnchor.constraint(equalTo: messageLabelContainer.widthAnchor)
        ])
    }

    
    @objc func dismissVC() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        dismiss(animated: true)
    }
}

