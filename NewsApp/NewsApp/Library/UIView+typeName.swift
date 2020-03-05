//
//  UIView+typeName.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

extension UIView {
    static var typeName: String {
        return String(describing: self)
    }
    
    func makeRoundedCorners(with avg: CGFloat) {
        layer.cornerRadius = self.frame.height / avg
    }
}
