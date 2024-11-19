//
//  ProfileTabsCollectionReusableView.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 18.11.2024.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
