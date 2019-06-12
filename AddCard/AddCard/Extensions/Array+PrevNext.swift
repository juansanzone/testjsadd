//
//  Array+PrevNext.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 5/19/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func next(fromItem: Element?) -> Element? {
        guard let item = fromItem else { return nil }
        guard let currentIndex = index(of: item) else { return nil }
        let newIndex = currentIndex + 1
        if indices.contains(newIndex) {
            return self[newIndex]
        }
        return nil
    }

    func prev(fromItem: Element?) -> Element? {
        guard let item = fromItem else { return nil }
        guard let currentIndex = index(of: item) else { return nil }
        let newIndex = currentIndex - 1
        if indices.contains(newIndex) {
            return self[newIndex]
        }
        return nil
    }
}
