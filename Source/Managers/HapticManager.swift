//
//  HapticManager.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/2/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import UIKit

struct HapticManager {
    static func success() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
    }

    static func error() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.error)
    }

    static func warning() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.warning)
    }

    static func tap() {
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
}
