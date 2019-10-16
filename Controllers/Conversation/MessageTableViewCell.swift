//
//  MessageCollectionViewCell.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        //        containerView.clipsToBounds = true
        //        containerView.layer.masksToBounds = true
        //        containerView.layer.cornerRadius = 18
        //        containerView.backgroundColor = .blue
        return containerView
    }()

    lazy var bubbleImageView: UIImageView = {
        let containerView = UIImageView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.clipsToBounds = true
//        containerView.layer.masksToBounds = true
//        containerView.layer.cornerRadius = 18
//        containerView.backgroundColor = .blue
        return containerView
    }()

    lazy var lblMessage: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 15
    }

    func setupViews() {
        selectionStyle = .none
        addSubview(containerView)
//        addSubview(bubbleImageView)
        addSubview(lblMessage)
    }

    func setupLayout() {
        let metrics = ["vspace": 20, "hspace": 20]

        lblMessage.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.6).isActive = true

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vspace-[lblMessage]-vspace-|", options: [], metrics: metrics, views: ["lblMessage": lblMessage]))

        containerView.leadingAnchor.constraint(equalTo: lblMessage.leadingAnchor, constant: -15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: lblMessage.trailingAnchor, constant: 15).isActive = true
        containerView.topAnchor.constraint(equalTo: lblMessage.topAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 10).isActive = true
    }

    func configure(with message: Message) {
        lblMessage.text = message.text
    }
}

class LeftMessageViewCell: MessageViewCell {
    override func setupViews() {
        super.setupViews()
        containerView.backgroundColor = #colorLiteral(red: 0.7506764531, green: 0.7506943345, blue: 0.7506847978, alpha: 1)
        bubbleImageView.image = UIImage(named: "left_bubble")?.withRenderingMode(.alwaysTemplate)
        bubbleImageView.tintColor = #colorLiteral(red: 0.7506764531, green: 0.7506943345, blue: 0.7506847978, alpha: 1)
    }

    override func setupLayout() {
        super.setupLayout()
        let metrics = ["vspace": 20, "hspace": 30]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-hspace-[lblMessage]-hspace@249-|", options: [], metrics: metrics, views: ["lblMessage": lblMessage]))

//        bubbleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10).isActive = true
//        bubbleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//        bubbleImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//        bubbleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    }
}

class RightMessageViewCell: MessageViewCell {
    override func setupViews() {
        super.setupViews()
        containerView.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.5529411765, blue: 0.9333333333, alpha: 1)
        bubbleImageView.image = UIImage(named: "right_bubble")?.withRenderingMode(.alwaysTemplate)
        bubbleImageView.tintColor = #colorLiteral(red: 0.3019607843, green: 0.5529411765, blue: 0.9333333333, alpha: 1)
    }

    override func setupLayout() {
        super.setupLayout()
        let metrics = ["vspace": 20, "hspace": 30]

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-hspace@249-[lblMessage]-hspace-|", options: [], metrics: metrics, views: ["lblMessage": lblMessage]))

//        bubbleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
//        bubbleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//        bubbleImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//        bubbleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    }
}
