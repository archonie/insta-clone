//
//  Extensions.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 13.11.2024.
//


import UIKit

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    public var top: CGFloat  {
        return frame.origin.y
    }
    public var bottom: CGFloat  {
        return frame.origin.y + height
    }
    public var left: CGFloat  {
        return frame.origin.x
    }
    public var right: CGFloat  {
        return frame.origin.x + width
    }
}
