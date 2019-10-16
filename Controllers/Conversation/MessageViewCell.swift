//
//  MessageCollectionViewCell.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    lazy var bubbleImageView: UIImageView = {
        let containerView = UIImageView()
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.image = UIImage(named: "right_bubble")
        return containerView
    }()

    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    lazy var lblMessage: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }

    func setupViews() {
        selectionStyle = .none
        addSubview(containerView)
        addSubview(lblMessage)
    }

    func setupLayout() {
        let metrics = ["hspace": 20, "vspace": 20]

        lblMessage.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8).isActive = true

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vspace-[lblMessage]-vspace-|", options: [], metrics: metrics, views: ["lblMessage": lblMessage]))

        containerView.leftAnchor.constraint(equalTo: lblMessage.leftAnchor, constant: -10).isActive = true
        containerView.rightAnchor.constraint(equalTo: lblMessage.rightAnchor, constant: 10).isActive = true
        containerView.topAnchor.constraint(equalTo: lblMessage.topAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 10).isActive = true
    }

    func configure(with message: Message) {
        lblMessage.text = message.text
    }
}

class RightMessageViewCell: MessageViewCell {
    override func setupViews() {
        super.setupViews()
        containerView.backgroundColor = #colorLiteral(red: 0.7506764531, green: 0.7506943345, blue: 0.7506847978, alpha: 1)
    }

    override func setupLayout() {
        super.setupLayout()
        let metrics = ["hspace": 25, "vspace": 20]

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-hspace@249-[lblMessage]-hspace-|", options: [], metrics: metrics, views: ["lblMessage": lblMessage]))
    }
}

class LeftMessageViewCell: MessageViewCell {
    override func setupViews() {
        super.setupViews()
        containerView.backgroundColor = #colorLiteral(red: 0.3668133616, green: 0.632142365, blue: 0.9478088021, alpha: 1)
    }

    override func setupLayout() {
        super.setupLayout()
        let metrics = ["hspace": 25, "vspace": 20]

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-hspace-[lblMessage]-hspace@249-|", options: [], metrics: metrics, views: ["lblMessage": lblMessage]))
    }
}
