//
//  ResourceManager.swift
//  MLAddCard
//
//  Created by Juan sebastian Sanzone on 6/2/19.
//

import Foundation


class ResourceManager {
    static func getImage(_ name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle(for: ResourceManager.self), compatibleWith: nil)
    }
}

