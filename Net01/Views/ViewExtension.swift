//
//  ViewExtension.swift
//  Net01
//
//  Created by Alexey Pavlov on 26.02.2021.
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
