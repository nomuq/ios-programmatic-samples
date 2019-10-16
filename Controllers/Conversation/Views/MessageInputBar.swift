//
//  MessageInputBar.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

class MessageInputBar: UIView {
    lazy var txtView: UITextView = {
        var textView: UITextView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = true
        textView.showsVerticalScrollIndicator = false
        textView.textContainerInset.left = 15
        textView.textContainerInset.right = 15
        textView.layer.borderWidth = 1
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()

    lazy var btnSend: UIButton = {
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitle("Send", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(txtView)
        addSubview(btnSend)
        setupLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        txtView.layer.cornerRadius = txtView.bounds.height * 0.5
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[txtView]-[btnSend(==60)]-10-|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: ["txtView": txtView, "btnSend": btnSend]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[txtView(>=40)]-10-|", options: [], metrics: nil, views: ["txtView": txtView, "btnSend": btnSend]))
    }
}
