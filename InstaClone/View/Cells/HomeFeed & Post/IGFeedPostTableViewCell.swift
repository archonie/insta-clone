//
//  IGFeedPostTableViewCell.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 17.11.2024.
//

import UIKit
import SDWebImage
import AVFoundation

/// Cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(with post: UserPost) {
        
        postImageView.image = UIImage(named: "test")
        
        return
        //configure the cell
//        switch post.postType {
//        case .photo:
//            
//            imageView?.sd_setImage(with: post.postURL)
//        case .video:
//            player = AVPlayer(url: post.postURL)
//            playerLayer.player = player
//            playerLayer.player?.volume = 0
//            playerLayer.player?.play()
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        playerLayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

}
