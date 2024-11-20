//
//  UserFollowTableViewCell.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 21.11.2024.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func userFollowTableCellDidTapFollowButton(_ cell: UserFollowTableViewCell)
}

class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.backgroundColor = .blue
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.backgroundColor = .green
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        return button
    }()
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.width/5
        profileImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize).integral
        profileImageView.layer.cornerRadius = imageSize/2
        let labelHeight = profileImageView.height/2
        let buttonWidth: CGFloat = 100
        let labelWidth = contentView.width-10-imageSize-buttonWidth
        nameLabel.frame = CGRect(x: profileImageView.right+5, y: 5, width: labelWidth, height: labelHeight).integral
        usernameLabel.frame = CGRect(x: profileImageView.right+5, y: 5+labelHeight, width: labelWidth, height: labelHeight).integral
        followButton.frame = CGRect(x: contentView.width-buttonWidth-10, y: 5, width: buttonWidth, height: imageSize).integral
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapFollowButton() {
        
    }
    
    public func configure(with model: String) {
        nameLabel.text = model
    }
}
