//
//  InputListManagerNotifier.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/1/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import Foundation

protocol InputListManagerNotifier: NSObjectProtocol {
    func shouldMoveNext()
    func shouldMoveBack()
    func initStepDidShow()
    func shouldFinalize()
    func didMoveToCvv()
    func cvvDidDissapear()
    func didMoveToIdentification()
    func identificationDidDissapear()
    func shouldUpdateProgress(progressValue: Float)
}
