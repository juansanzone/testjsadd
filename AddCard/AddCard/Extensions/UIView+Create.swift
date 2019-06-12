//
//  UIView+Create.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/1/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import UIKit

extension UIView {
    static func createView(_ backgroundColor: UIColor? = nil) -> UIView {
        let targetView = UIView()
        targetView.backgroundColor = backgroundColor
        targetView.translatesAutoresizingMaskIntoConstraints = false
        return targetView
    }
}
