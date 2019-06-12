//
//  InputCardNotifier.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/1/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import UIKit

protocol InputCardNotifier: NSObjectProtocol {
    func shouldNext(from: InputCardView)
    func shouldPrev(from: InputCardView)
    func didChangeValue(newValue: String?, from: InputCardView)
}
