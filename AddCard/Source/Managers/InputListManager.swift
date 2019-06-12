//
//  InputListManager.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/1/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import UIKit
import MLUI

final class InputListManager: NSObject {
    // MARK: Privates
    private var inputViews : [InputCardView] = [InputCardView]() {
        didSet {
            currentInput = inputViews.first
        }
    }
    private var currentInput: InputCardView?
    private let spinner = MLSpinner(config: MLSpinnerConfig(size: .big, primaryColor: #colorLiteral(red: 0, green: 0.5409701467, blue: 1, alpha: 1), secondaryColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), text: nil)

    // MARK: Publics
    weak var notifierProtocol: InputListManagerNotifier?
    weak var dataNotifierProtocol: InputListManagerDataNotifier?

    enum InputStep: Int {
        case number = 0
        case expiration
        case name
        case cvv
        case identification
        case finish

        func getValue() -> String {
            switch self {
            case .number:
                return "k_number"
            case .expiration:
                return "k_expiration"
            case .name:
                return "k_name"
            case .cvv:
                return "k_ccv"
            case .identification:
                return "k_identification"
            default:
                return ""
            }
        }
    }

    // MARK: Init
    init(inputCardViews: [InputCardView]) {
        inputViews = inputCardViews
    }

    @discardableResult
    func render(inView: UIView) -> InputListManager  {
        var lastAdded: UIView?
        for (index, targetInput) in inputViews.enumerated() {
            inView.addSubview(targetInput.render())
            if index == 0 {
                NSLayoutConstraint.activate([
                    targetInput.leadingAnchor.constraint(equalTo: inView.leadingAnchor, constant: 16),
                    targetInput.trailingAnchor.constraint(equalTo: inView.trailingAnchor, constant: -16),
                    targetInput.heightAnchor.constraint(equalToConstant: 80),
                    targetInput.topAnchor.constraint(equalTo: inView.topAnchor, constant: 10),
                    ])
            } else {
                guard let lastCardAdded = lastAdded else { break }
                NSLayoutConstraint.activate([
                    targetInput.leadingAnchor.constraint(equalTo: lastCardAdded.leadingAnchor),
                    targetInput.trailingAnchor.constraint(equalTo: lastCardAdded.trailingAnchor),
                    targetInput.heightAnchor.constraint(equalTo: lastCardAdded.heightAnchor, multiplier: 1),
                    targetInput.topAnchor.constraint(equalTo: lastCardAdded.bottomAnchor, constant: 10)
                    ])
                targetInput.addSkeleton()
                targetInput.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            lastAdded = targetInput
        }
        return self
    }

    func initBecomeFirstResponder() {
        if let currentStepView = inputViews.first {
            currentInput = currentStepView
            currentStepView.doFocus().delegate = self
            if let currentProgressValue = getProgressValue() {
                notifierProtocol?.shouldUpdateProgress(progressValue: currentProgressValue)
            }
        }
    }

    func showLoadingAnimation() {
        guard let targetInput = currentInput else { return }
        targetInput.resignFocus()

        let newSize: CGFloat = 60

        let screenCenter = UIScreen.main.bounds.width / 2
        let newFrame = CGRect(x: screenCenter - newSize / 2, y: targetInput.frame.origin.y, width: newSize, height: newSize)

        for subviews in targetInput.subviews {
            subviews.alpha = 0
        }

        targetInput.addSubview(spinner)

        UIView.animate(withDuration: 0.4, animations: {
            targetInput.frame = newFrame
            targetInput.layer.cornerRadius = newSize / 2
        }) { _ in
            let spinerFrame = CGRect(x: targetInput.frame.width - targetInput.frame.width / 2 - self.spinner.frame.width / 2, y: targetInput.frame.height - targetInput.frame.height / 2 - self.spinner.frame.height / 2, width: self.spinner.frame.width, height: self.spinner.frame.height)
            self.spinner.frame = spinerFrame
            self.spinner.show()
        }
    }

    @discardableResult
    func hideLoadingAnimation() -> (CGRect?, UIView?, UIView?) {
        spinner.hide()
        return (currentInput?.frame, currentInput?.superview, currentInput)
    }

    func shouldChangeToNextStep() {
        if let actualInput = currentInput {
            shouldNext(from: actualInput)
        }
    }

    func shouldChangeToPrevStep() {
        if let actualInput = currentInput {
            shouldPrev(from: actualInput)
        }
    }

    func isFirstField() -> Bool {
        if let cIndex = getCurrentIndexValue(), cIndex == 0 {
            return true
        }
        return false
    }
}

// MARK: Privates
extension InputListManager {
    private func animateInputs(current: InputCardView, next: InputCardView, isBackAction: Bool = false) {
        UIView.animate(withDuration: 0.75, animations: {
            current.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            next.transform = CGAffineTransform.identity
            if !isBackAction {
                current.alpha = 0
                next.removeSkeleton()
            } else {
                next.alpha = 1
                current.addSkeleton()
            }
        }) { _ in

            if next.inputStep == .identification {
                self.notifierProtocol?.didMoveToIdentification()
                return
            } else if current.inputStep == .identification {
                self.notifierProtocol?.identificationDidDissapear()
                return
            }

            if next.inputStep == .cvv {
                self.notifierProtocol?.didMoveToCvv()
            } else {
                self.notifierProtocol?.cvvDidDissapear()
            }
        }
    }

    private func getProgressValue() -> Float? {
        guard let currentIndex = getCurrentIndexValue() else { return nil }
        let totalInputs = inputViews.count
        let portion: Float = 1 / Float(totalInputs)
        return portion * Float(currentIndex + 1) //TODO:Juan. Check with UX ¿+1 for init?
    }

    private func getCurrentIndexValue() -> Int? {
        if let current = currentInput, let tIndex = inputViews.firstIndex(of: current)  {
            return tIndex
        }
        return nil
    }
}

// MARK: InputCardNotifier protocol.
extension InputListManager: InputCardNotifier {

    func shouldNext(from: InputCardView) {
        guard let nextView = inputViews.next(fromItem: from) else {
            if from.isValid() {
                notifierProtocol?.shouldFinalize()
            }
            return
        }

        if from.isValid() {
            TyperManager.shared.disableTyper()
            currentInput = nextView
            nextView.doFocus().delegate = self
            notifierProtocol?.shouldMoveNext()
            animateInputs(current: from, next: nextView)
            nextView.removeSkeleton()

            if let newProgressValue = getProgressValue() {
                notifierProtocol?.shouldUpdateProgress(progressValue: newProgressValue)
            }
        }
    }

    func shouldPrev(from: InputCardView) {
        guard let prevView = inputViews.prev(fromItem: from) else {
            notifierProtocol?.initStepDidShow()
            return
        }
        currentInput = prevView
        prevView.doFocus().delegate = self
        notifierProtocol?.shouldMoveBack()
        animateInputs(current: from, next: prevView, isBackAction: true)

        if let newProgressValue = getProgressValue() {
            notifierProtocol?.shouldUpdateProgress(progressValue: newProgressValue)
        }
    }

    func didChangeValue(newValue: String?, from: InputCardView) {
        var returnValue: String = ""
        if let inputValue = from.getValue() {
            returnValue = inputValue
        }

        let kValue = from.inputStep.getValue()
        if kValue != "" {
            PersisterService.save.field(key: kValue, text: returnValue)
        }

        switch from.inputStep {
        case .cvv:
            dataNotifierProtocol?.didChangeCvv(newValue: returnValue)
            break
        case .identification:
            dataNotifierProtocol?.didChangeIdentification(newValue: returnValue)
            break
        case .expiration:
            dataNotifierProtocol?.didChangeExpiration(newValue: returnValue)
            break
        case .number:
            dataNotifierProtocol?.didChangeNumber(newValue: returnValue)
            break
        case .name:
            dataNotifierProtocol?.didChangeName(newValue: returnValue)
            break
        default:
            break
        }
    }
}
