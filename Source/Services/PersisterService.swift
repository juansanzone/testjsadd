//
//  PersisterService.swift
//  MLAddCard
//
//  Created by Juan sebastian Sanzone on 6/10/19.
//

import UIKit

struct PersisterService {
    static func getContext() -> UserDefaults {
        return UserDefaults.standard
    }
}

extension PersisterService {
    struct save {
        static func field(key: String, text: String) {
            let context = PersisterService.getContext()
            context.set(text, forKey: key)
            context.synchronize()
        }
    }

    struct get {
        static func field(key: String) -> String? {
            let context = PersisterService.getContext()
            if let str = context.object(forKey: key) as? String {
                return str
            }
            return nil
        }
    }
}
