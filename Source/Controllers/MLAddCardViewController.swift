//
//  MLAddCardViewController.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/2/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import UIKit
import MLCardDrawer

open class MLAddCardViewController: UIViewController {
    private let viewBackgroundColor = #colorLiteral(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    private var cardDrawer: MLCardDrawerController?
    private var cardUIHandler: CardUI = DefaultUIHandler()
    private var cardDataHandler: CardData = DefaultDataHandler()
    private var inputListManager = InputListManager(inputCardViews: [])
    private var verticalConstraint: NSLayoutConstraint?
    private let yVerticalOffset: CGFloat = 90
    private let inputYDistanceToTop: CGFloat = 8
    private var inputListContainer: UIView = UIView.createView()
    private var binService = BinService()

    private var circleView: UIView = UIView()
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var identificationView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var identificationLabel: UILabel!

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        showContainerView()
        binService.initialize()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }

    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let currentEvent = event else { return }
        if UIEvent.EventSubtype.motionShake == currentEvent.subtype {
            inputListManager.shouldChangeToNextStep()
        }
    }

    @IBAction func didSwipeUp(_ sender: UISwipeGestureRecognizer) {
        inputListManager.shouldChangeToNextStep()
    }

    @IBAction func didSwipeDown(_ sender: Any) {
        inputListManager.shouldChangeToPrevStep()
        if !inputListManager.isFirstField() {
            HapticManager.tap()
        }
    }
}

// MARK: Public API.
extension MLAddCardViewController {
    public static func create() -> MLAddCardViewController {
        return MLAddCardViewController(nibName: "MLAddCardViewController", bundle: Bundle(for: MLAddCardViewController.self))
    }
}

// MARK: Privates.
extension MLAddCardViewController {
    private func setupUI() {
        // Hide navigation bar bottom line
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        // Background
        view.backgroundColor = viewBackgroundColor

        // Setup card Container view.
        cardContainerView.addShadow()

        // Add card drawer into Container view.
        cardDrawer = MLCardDrawerController(cardUIHandler, cardDataHandler)
        guard let cardDrawer = cardDrawer else { return }
        cardDrawer.setUp(inView: cardContainerView)
        cardContainerView.layer.cornerRadius = cardDrawer.view.layer.cornerRadius

        // Setup InputList Container view.
        inputListContainer = UIView.createView()
        cardContainerView.superview?.insertSubview(inputListContainer, belowSubview: cardContainerView)
        NSLayoutConstraint.activate([
            inputListContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputListContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

        self.verticalConstraint = inputListContainer.topAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: inputYDistanceToTop)
        self.verticalConstraint?.isActive = true

        // Add inputs into InputList Container View.
        inputListManager = InputListManager(inputCardViews: [
            InputCardView(step: .number, fieldProperty: MLCardFieldProperty(nil, "$$$$ $$$$ $$$$ $$$$", 16, 16)),
            InputCardView(step: .expiration, fieldProperty: MLCardFieldProperty(nil, "$$/$$", 4, 4)),
            InputCardView(step: .name, fieldProperty: MLCardFieldProperty(PersisterService.get.field(key:  InputListManager.InputStep.name.getValue()), nil, 3, 50)),
            InputCardView(step: .cvv, fieldProperty: MLCardFieldProperty(nil, nil, 3, 3)),
            InputCardView(step: .identification, fieldProperty: MLCardFieldProperty(PersisterService.get.field(key: InputListManager.InputStep.identification.getValue()), "$$.$$$.$$$", 8, 8))
        ])

        inputListManager.render(inView: inputListContainer)
        inputListManager.notifierProtocol = self
        inputListManager.dataNotifierProtocol = self

        if let currentUserName = PersisterService.get.field(key: InputListManager.InputStep.name.getValue()) {
            cardDataHandler.name = currentUserName.uppercased()
        }

        inputListContainer.alpha = 0
        cardContainerView.alpha = 0

        identificationView.alpha = 0
        identificationView.addShadow()
        identificationLabel.text = PersisterService.get.field(key: InputListManager.InputStep.identification.getValue())

        cardDrawer.show()
    }

    private func setupKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    private func showContainerView() {
        inputListManager.initBecomeFirstResponder()
        UIView.animate(withDuration: 0.8) { [weak self] in
            self?.inputListContainer.alpha = 1
            self?.cardContainerView.alpha = 1
        }
    }
}

// MARK: Transitions poc draft.
extension MLAddCardViewController {
    func finishTransition() {
        let (frame, superView, cInput) = inputListManager.hideLoadingAnimation()
        if let superV = superView, let tFrame = frame, let tInput = cInput {
            circleView = UIView(frame: tFrame)
            circleView.layer.cornerRadius = tInput.layer.cornerRadius
            circleView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            circleView.alpha = 0
            tInput.alpha = 0
            //superV.alpha = 0
            superV.insertSubview(circleView, at: 100)

            self.identificationView.alpha = 0
            self.cardContainerView.alpha = 0

            UIView.animate(withDuration: 0.3, animations: {
                self.circleView.alpha = 1
            }) {  _ in
                tInput.removeFromSuperview()
                self.doExplodeTransition()
            }
        }
    }

    private func doExplodeTransition() {
        UIView.animate(withDuration: 0.4, animations: {
            self.circleView.transform = CGAffineTransform(scaleX: 90, y: 90)
        }) { _ in
            self.modalTransitionStyle = .crossDissolve
            self.dismiss(animated: true, completion: {

            })
        }
    }
}

// MARK: InputListManagerNotifier
extension MLAddCardViewController: InputListManagerNotifier {
    func shouldUpdateProgress(progressValue: Float) {
        self.progressView.setProgress(Float(progressValue), animated: true)
    }

    func didMoveToIdentification() {
        let identificationNewFrame = cardContainerView.frame
        let cardNewFrame = CGRect(x: cardContainerView.frame.origin.x - cardContainerView.frame.width - cardContainerView.frame.width * 0.5 , y: cardContainerView.frame.origin.y, width: cardContainerView.frame.width, height: cardContainerView.frame.height)
        UIView.animate(withDuration: 0.5, animations: {
            self.identificationView.alpha = 1
            self.cardContainerView.frame = cardNewFrame
            self.identificationView.frame = identificationNewFrame
        }, completion: { _ in

        })
    }

    func identificationDidDissapear() {
        self.identificationView.alpha = 0
    }

    func didMoveToCvv() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
            self.cardDrawer?.showSecurityCode()
        }
    }

    func cvvDidDissapear() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
            self.cardDrawer?.show()
        }
    }

    func shouldMoveNext() {
        moveNext()
    }

    func shouldMoveBack() {
        moveBack()
    }

    func initStepDidShow() {
        // TODO: Do anything (?)
        print("initStepDidShow")
    }

    func shouldFinalize() {
        // Should finish. Last input finished.
        progressView.setProgress(1, animated: true)
        removeKeyboardNotifications()
        inputListManager.showLoadingAnimation()

        // Simulate add card request
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.finishTransition()
        }
    }
}

// MARK: InputListManagerDataNotifier
extension MLAddCardViewController: InputListManagerDataNotifier {
    func didChangeName(newValue: String) {
        cardDataHandler.name = newValue.uppercased()
    }

    func didChangeExpiration(newValue: String) {
        cardDataHandler.expiration = newValue
    }

    func didChangeNumber(newValue: String) {
        cardDataHandler.number = newValue.replacingOccurrences(of: " ", with: "")
        
        if newValue.count == 6 {
            let cardColor = binService.getColor(bin: newValue)
            if cardUIHandler.cardBackgroundColor != cardColor {
                cardUIHandler = DefaultUIHandler(withColor: binService.getColor(bin: newValue))
                cardDrawer?.cardUI = cardUIHandler
            }
        } else if newValue.count == 5 {
            if cardUIHandler.cardBackgroundColor != UIColor.lightGray {
                cardUIHandler = DefaultUIHandler()
                cardDrawer?.cardUI = cardUIHandler
            }
        }
    }

    func didChangeCvv(newValue: String) {
        cardDataHandler.securityCode = newValue
    }

    func didChangeIdentification(newValue: String) {
        identificationLabel.text = newValue
    }
}

// MARK: Selector funcs.
extension MLAddCardViewController {
    @objc func moveNext() {
        UIView.animate(withDuration: 0.8, animations: {
            self.verticalConstraint?.constant = self.verticalConstraint!.constant - self.yVerticalOffset
            self.view.layoutIfNeeded()
        }, completion: { _ in
            TyperManager.shared.enableTyper()
        })
    }

    @objc func moveBack() {
        UIView.animate(withDuration: 0.8, animations: {
            self.verticalConstraint?.constant = self.verticalConstraint!.constant + self.yVerticalOffset
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            TyperManager.shared.enableTyper()
        })
    }

    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            UIView.animate(withDuration: 0.3) {
                self.containerBottomConstraint.constant = 0.0
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                // TODO: Juan. Review 30 delta value.
                self.containerBottomConstraint.constant = keyboardViewEndFrame.height - 30
                self.view.layoutIfNeeded()
            }
        }
    }
}
