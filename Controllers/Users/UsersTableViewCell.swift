//
//  UsersTableViewCell.swift
//  GithubDM
//
//  Created by Satish on 10/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    lazy var imgAvarar: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "16605023")
        return imageView
    }()

    lazy var lblName: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
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

    func setupViews() {
        accessoryType = .disclosureIndicator
        separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        addSubview(imgAvarar)
        addSubview(lblName)
    }

    func setupLayout() {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgAvarar(==50)]-15-[lblName]-40-|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: ["imgAvarar": imgAvarar, "lblName": lblName]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[imgAvarar(==50)]-15-|", options: [], metrics: nil, views: ["imgAvarar": imgAvarar, "lblName": lblName]))
    }

    func configure(user: User) {
        lblName.text = "@\(user.login)"
    }
}
