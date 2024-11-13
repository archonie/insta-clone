//
//  LoginHeaderView.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 13.11.2024.
//

import UIKit


struct LoginHeaderViewModel {
    let backgroundImage: UIImage
    let textImage: UIImage
}

class LoginHeaderView: UIView {
    
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let textImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImage)
        addSubview(textImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = bounds
        textImage.frame = CGRect(x: width/4, y: safeAreaInsets.top, width: width/2, height: height-safeAreaInsets.top)
    }
    
    func configure(with viewModel: LoginHeaderViewModel) {
        backgroundImage.image = viewModel.backgroundImage
        textImage.image = viewModel.textImage
    }

}
