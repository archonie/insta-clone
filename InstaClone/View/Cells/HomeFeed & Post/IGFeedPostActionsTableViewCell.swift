//
//  IGFeedPostActionsTableViewCell.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 17.11.2024.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionsTableViewCell"

    weak var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(with post: UserPost) {
        //configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height-10
        likeButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        commentButton.frame = CGRect(x: likeButton.right, y: 0, width: buttonSize, height: buttonSize)
        sendButton.frame = CGRect(x: commentButton.right,  y: 0, width: buttonSize, height: buttonSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }

}
