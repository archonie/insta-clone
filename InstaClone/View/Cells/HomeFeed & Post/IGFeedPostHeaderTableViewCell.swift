//
//  IGFeedPostHeaderTableViewCell.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 17.11.2024.
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderTableViewCell"

    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(with model: User) {
        //configure the cell
        usernameLabel.text = model.username
        profileImageView.image = UIImage(systemName: "person.circle")
        //profileImageView.sd_setImage(with: model.profilePhoto)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height-16
        profileImageView.frame = CGRect(x: 8, y: 8, width: size, height: size)
        profileImageView.layer.cornerRadius = size/2
        moreButton.frame = CGRect(x: contentView.width-size, y: 8, width: size, height: size)
        usernameLabel.frame = CGRect(x: profileImageView.right+10, y: 8, width: contentView.width-(size*2)-10, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        usernameLabel.text = nil
    }
    
    @objc private func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }

}
