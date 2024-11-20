//
//  ProfileTabsCollectionReusableView.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 18.11.2024.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func profileTabsDidTapGridButton(_ tabs: ProfileTabsCollectionReusableView)
    func profileTabsDidTapTaggedButton(_ tabs: ProfileTabsCollectionReusableView)
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - Constants.padding*2
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX , y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: gridButtonX+(width/2) , y: Constants.padding, width: size, height: size)
    }
    
    private func addSubviews() {
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    
    private func addActions() {
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    @objc private func didTapGridButton() {
        gridButton.setBackgroundImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        taggedButton.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        delegate?.profileTabsDidTapGridButton(self)
    }
    
    @objc private func didTapTaggedButton() {
        gridButton.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        taggedButton.setBackgroundImage(UIImage(systemName: "tag.fill"), for: .normal)
        delegate?.profileTabsDidTapTaggedButton(self)
    }
    

}
