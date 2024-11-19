//
//  ProfileInfoCollectionReusableView.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 18.11.2024.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
