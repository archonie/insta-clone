//
//  IGFeedPostHeaderTableViewCell.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 17.11.2024.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .red
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure() {
        //configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
