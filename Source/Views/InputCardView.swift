//
//  InputCardView.swift
//  AddCard
//
//  Created by Juan sebastian Sanzone on 6/1/19.
//  Copyright © 2019 Juan Sebastian Sanzone. All rights reserved.
//

import UIKit
import TLCustomMask

typealias MLCardFieldProperty = (defaultValue: String?, pattern: String?, minLenght: Int, maxLenght: Int)

final class InputCardView: UIView {
    private let cardCornerRadius: CGFloat = 8
    private static let accesoryBackgroundColor = #colorLiteral(red: 0.7601495385, green: 0.7834227085, blue: 0.8189848661, alpha: 1)
    private static let labelTextColor = UIColor.gray
    private static let inputTextColor = #colorLiteral(red:0.24, green:0.24, blue:0.24, alpha:1.0)
    private static let errorColor = #colorLiteral(red:0.91, green:0.36, blue:0.36, alpha:0.8)
    private let background = UIColor.white
    private let labelFont = UIFont(name: "Arial", size: 12)
    private static let highlightColor = #colorLiteral(red:0.00, green:0.57, blue:0.82, alpha:1.0)
    private static let bottomLineColor = #colorLiteral(red:0.00, green:0.57, blue:0.82, alpha:1.0)
    private static let skeletonColor = #colorLiteral(red: 0.7601495385, green: 0.7834227085, blue: 0.8189848661, alpha: 1)
    private let input = UITextField()
    private var customMask: TLCustomMask?
    private let bottomLine = UIView.createView(bottomLineColor)
    private var maxLenght: Int = 50 // Default max lenght. TODO: Config (?)
    var property: MLCardFieldProperty?

    // MARK: Publics
    var inputStep: InputListManager.InputStep = .number
    weak var delegate: InputCardNotifier?

    convenience init(step: InputListManager.InputStep, fieldProperty: MLCardFieldProperty? = nil) {
        self.init()
        property = fieldProperty
        inputStep = step
        if let maskPattern = fieldProperty?.pattern {
            customMask = TLCustomMask(formattingPattern: maskPattern)
            maxLenght = maskPattern.count
        } else if let targetMaxLenght = property?.maxLenght {
            maxLenght = targetMaxLenght
        }
    }

    @discardableResult
    func render() -> InputCardView {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = background
        addShadow()
        layer.cornerRadius = cardCornerRadius

        // Title label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.textColor = InputCardView.labelTextColor
        titleLabel.text = getTitle()
        titleLabel.font = labelFont
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)
            ])

        // Textfield Input
        input.translatesAutoresizingMaskIntoConstraints = false
        input.autocorrectionType = UITextAutocorrectionType.no
        input.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // Default config input
        input.text = property?.defaultValue?.uppercased()
        input.maxLength = maxLenght

        if inputStep == .name {
            input.keyboardType = .default
        } else {
            input.keyboardType = .numberPad
        }

        input.delegate = self
        input.tintColor = InputCardView.highlightColor
        input.textColor = InputCardView.inputTextColor
        input.autocapitalizationType = .words
        // input.clearButtonMode = .whileEditing - Disable for now
        addSubview(input)
        NSLayoutConstraint.activate([
            input.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            input.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            input.heightAnchor.constraint(equalToConstant: 28),
            input.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
            ])

        // Bottom highlight line
        addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 0),
            bottomLine.leadingAnchor.constraint(equalTo: input.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: input.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
            ])

        // Accesory view
        let toolBar = UIToolbar()
        // TODO-Juan: Translations
        let backBtn = UIBarButtonItem(title: "Anterior", style: .plain, target: self, action: #selector(doPrev))
        let nextBtn = UIBarButtonItem(title: "Siguiente", style: .plain, target: self, action: #selector(doNext))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.tintColor = InputCardView.highlightColor
        toolBar.items = [backBtn, space, space, nextBtn]
        toolBar.sizeToFit()
        // toolBar.clipsToBounds = true // Remove top border of toolbar.
        input.inputAccessoryView = toolBar

        return self
    }

    func addSkeleton() {
        self.alpha = 0.3
        bottomLine.backgroundColor = InputCardView.skeletonColor
    }

    func removeSkeleton() {
        self.alpha = 1
        bottomLine.backgroundColor = InputCardView.bottomLineColor
    }

    func resignFocus() {
        input.resignFirstResponder()
    }

    func isValid() -> Bool {
        // TODO-Juan: Validators for each field.
        guard let countToValidate = input.text?.count else { return false }
        var minLenght: Int = 0
        if let minValue = property?.minLenght {
            minLenght = minValue
        }

        if countToValidate >= minLenght {
            input.placeholder = ""
            bottomLine.backgroundColor = InputCardView.highlightColor
            HapticManager.success()
            return true
        } else {
            bottomLine.backgroundColor  = InputCardView.errorColor
            // TODO-Juan: Message for each field
            input.placeholder = "Complete este campo"
            HapticManager.error()
            return false
        }
    }

    func getValue() -> String? {
        return input.text
    }

    @objc func doPrev() {
        delegate?.shouldPrev(from: self)
    }

    @objc func doNext() {
        delegate?.shouldNext(from: self)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        updateTextField(textField)
    }

    func updateTextField(_ textField: UITextField) {
         guard let inputCharsCount = textField.text?.count else { return }
         let sendValue: String? = textField.text
         delegate?.didChangeValue(newValue: sendValue, from: self)
         if inputCharsCount >= maxLenght {
            delegate?.shouldNext(from: self)
         }
    }

    @discardableResult
    func doFocus() -> InputCardView {
        input.becomeFirstResponder()
        return self
    }

    private func getTitle() -> String? {
        switch inputStep {
        case .number:
            return "Número de tarjeta"
        case .name:
            return "Nombre y Apellido"
        case .expiration:
            return "Fecha de vencimiento"
        case .cvv:
            return "CVV"
        case .identification:
            return "Número de documento"
        default:
            return nil
        }
    }
}

// Textfield delegate.
extension InputCardView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
        if !TyperManager.shared.isTypeEnabled() { return false }
        if let targetMask = customMask {
            textField.text = targetMask.formatStringWithRange(range: range, string: string)
            updateTextField(textField)
            return false
        }
        return true
    }
}

// Max lenght support.
private var kAssociationKeyMaxLength: Int = 0
extension UITextField {
    var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }

    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        let selection = selectedTextRange
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)

        selectedTextRange = selection
    }
}
