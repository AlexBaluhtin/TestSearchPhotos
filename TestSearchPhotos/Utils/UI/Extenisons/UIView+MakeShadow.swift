//
//  UIView+MakeShadow.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 3.01.23.
//

import UIKit

extension UIView {
    func makeShadow(cornerRadius: Int = 20) {
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
