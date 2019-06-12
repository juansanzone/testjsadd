//
//  CardHandlers.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 5/15/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import Foundation
import UIKit

import MLCardDrawer

final class DefaultUIHandler: NSObject, CardUI {
    var placeholderName = "NOMBRE Y APELLIDO"
    var placeholderExpiration = "MM/AA"
    var bankImage: UIImage? = nil
    var cardPattern = [4, 4, 4, 4]
    var cardFontColor: UIColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    var cardLogoImage: UIImage? = nil
    var cardBackgroundColor: UIColor = UIColor.lightGray
    var securityCodeLocation: MLCardSecurityCodeLocation = .back
    var defaultUI = true
    var securityCodePattern = 3

    init(withColor: UIColor = UIColor.lightGray) {
        cardBackgroundColor = withColor
    }
}

final class TestUIHandler: NSObject, CardUI {
    var placeholderName = "NOMBRE Y APELLIDO"
    var placeholderExpiration = "MM/AA"
    var bankImage: UIImage? = ResourceManager.getImage("galicia_light")
    var cardPattern = [4, 4, 4, 4]
    var cardFontColor: UIColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    var cardLogoImage: UIImage? = ResourceManager.getImage("master")
    var cardBackgroundColor: UIColor = UIColor(red:1.00, green:0.72, blue:0.00, alpha: 1)
    var securityCodeLocation: MLCardSecurityCodeLocation = .back
    var defaultUI = true
    var securityCodePattern = 3
}

final class DefaultDataHandler: NSObject, CardData {
    var name = "NOMBRE Y APELLIDO"
    var number = ""
    var securityCode = ""
    var expiration = "MM/AA"
}
