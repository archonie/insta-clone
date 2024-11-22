//
//  UserFollowTableViewCell.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 21.11.2024.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func userFollowTableCellDidTapFollowButton(model: UserFollowTableCellModel)
}


enum FollowState {
    case following, notFollowing
}

struct UserFollowTableCellModel {
    let username: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserFollowTableCellModel?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "@joe"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 6
        profileImageView.frame = CGRect(x: 3, y: 3, width: imageSize, height: imageSize).integral
        profileImageView.layer.cornerRadius = contentView.height/2
        let labelHeight = contentView.height/2
        let buttonWidth: CGFloat = contentView.width > 500 ? 220 : contentView.width/4
        let labelWidth = contentView.width-imageSize-buttonWidth-28
        followButton.frame = CGRect(x: contentView.width-buttonWidth-5, y: (contentView.height-40)/2, width: buttonWidth, height: 40).integral
        nameLabel.frame = CGRect(x: profileImageView.right+20, y: 5, width: labelWidth, height: labelHeight).integral
        usernameLabel.frame = CGRect(x: profileImageView.right+20, y: labelHeight-5, width: labelWidth, height: labelHeight).integral
        
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
        
        guard let model = self.model else { return }
        
        delegate?.userFollowTableCellDidTapFollowButton(model: model)
    }
    
    public func configure(with model: UserFollowTableCellModel) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .secondarySystemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            followButton.setTitleColor(.label, for: .normal)
        case .notFollowing:
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
            followButton.setTitleColor(.white, for: .normal)
        }
    }
}
