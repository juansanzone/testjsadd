//
//  InputListManagerDataNotifier.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/1/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import Foundation

protocol InputListManagerDataNotifier: NSObjectProtocol {
    func didChangeName(newValue: String)
    func didChangeExpiration(newValue: String)
    func didChangeNumber(newValue: String)
    func didChangeCvv(newValue: String)
    func didChangeIdentification(newValue: String)
}
