//
//  TyperManager.swift
//  MLAddCard
//
//  Created by Juan sebastian Sanzone on 6/12/19.
//

import Foundation

final class TyperManager {
    private var typeEnabled: Bool = true
    static let shared = TyperManager()

    func disableTyper() {
        typeEnabled = false
    }

    func enableTyper() {
        typeEnabled = true
    }

    func isTypeEnabled() -> Bool {
        return typeEnabled
    }
}
