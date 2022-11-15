//
//  FloatLabelTextField.swift
//  FloatLabelFields
//
//  Created by Fahim Farook on 28/11/14.
//  Copyright (c) 2014 RookSoft Ltd. All rights reserved.
//
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Objective-C version by Jared Verdi
//  https://github.com/jverdi/JVFloatLabeledTextField
//

import UIKit

@IBDesignable
open class FloatLabelTextField: UITextField {
    private let animationDuration = 0.3
    private var title = UILabel()
    private var messageLabel = UILabel()
    public var baseLineView = UIView()
    private lazy var secretEye: PasswordToggleView = {
        let eyeView = PasswordToggleView()
        let secretEyeSize: CGFloat = 24.0
        eyeView.backgroundColor = .clear
        eyeView.textField = self
        eyeView.frame = CGRect(x: self.frame.width - self.frame.height, y: 0.0, width: secretEyeSize, height: secretEyeSize)
        return eyeView
    }()

    var clearButtonColor = UIColor.gray {
        didSet {
            customClearButton.tintColor = clearButtonColor
        }
    }

    private lazy var customClearButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: ImageSize.navigation.size))
        let image = UIImage(named: "empty-field")?.resizeImage()
        button.setImage(image, for: .normal)
        button.tintColor = clearButtonColor
        return button
    }()

    private var usedHint: String?

    var validationType: InputValidationType = .none
    var customErrorMessage: String? = .none

     var placeHolderColor: UIColor? {
        didSet {
            guard var value = self.placeHolderColor else { return }
            if !isUserInteractionEnabled {
                value = value.withAlphaComponent(0.4)
            }
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                            attributes: [NSAttributedString.Key.foregroundColor: value])
        }
    }

    override open var accessibilityLabel: String? {
        get {
            guard super.accessibilityLabel == .none else {
                return super.accessibilityLabel
            }

            if text?.isEmpty == true {
                return placeholder
            } else {
                return (placeholder ?? "") + ", " + (text ?? "")
            }
        }
        set {
            super.accessibilityLabel = newValue
        }
    }

    override open var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }

    override open var attributedPlaceholder: NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }

    var titleFont: UIFont = UIFont.paragraph ?? UIFont.systemFont(ofSize: 15) {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }

     var showSecretEye: Bool = false {
        didSet {
            rightView = secretEye
            secretEye.isHidden = !showSecretEye
            secretEye.isUserInteractionEnabled = showSecretEye
        }
    }

     var showBaseline: Bool = true {
        didSet {
            baseLineView.isHidden = !showBaseline
        }
    }

     var hintYPadding: CGFloat = 0.0

     var baselineHeight: CGFloat = 0.5

     var titleYPadding: CGFloat = -5.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }

     var titleTextColour: UIColor = .darkGray
     var titleActiveTextColour: UIColor = .darkGray
     var errorTextColour: UIColor = .red
     var baselineNormalColor: UIColor = .gray
     var baselineActiveColor: UIColor = .gray
     var defaultTextColor: UIColor = .black

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        baseLineView.backgroundColor = baselineNormalColor
    }

    override open func layoutSubviews() {

        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder

        if isResp {
            baseLineView.backgroundColor = baselineActiveColor
            baselineHeight = 1.5
        } else {
            baselineHeight = 0.5
        }

        if isResp && text?.isEmpty != true {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if text?.isEmpty == true {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }

        if !showSecretEye {
            // Show delete button only if there's typed text
            rightViewMode = (text?.isEmpty == false && isFirstResponder) ? .always : .never
        }

        super.layoutSubviews()
        baseLineView.frame = CGRect(x: 0.0, y: frame.height, width: frame.width, height: baselineHeight)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        if text?.isEmpty == false {
            var top = ceil(title.font.lineHeight + hintYPadding/2)
            top = min(top, maxTopInset())
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            r = r.inset(by: inset)
        }
        return r.integral
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        if text?.isEmpty == false {
            var top = ceil(title.font.lineHeight + hintYPadding/2)
            top = min(top, maxTopInset())
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            r = r.inset(by: inset)
        }
        return r.integral
    }

    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        if text?.isEmpty == false {
            var top = ceil(title.font.lineHeight + hintYPadding/2)
            top = min(top, maxTopInset())
            r = CGRect(origin: CGPoint(x: r.origin.x, y: r.origin.y + (top * 0.5)),
                       size: ImageSize.navigation.size)
        }
        return r.integral
    }

    fileprivate func setup() {

        borderStyle = UITextField.BorderStyle.none
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        title.isAccessibilityElement = false
        if let str = placeholder {
            if !str.isEmpty {
                title.text = str
                title.sizeToFit()
            }
        }

        messageLabel.alpha = 0.0
        messageLabel.font = .paragraph

        baseLineView.isHidden = !showBaseline
        baseLineView.backgroundColor = baselineNormalColor

        clipsToBounds = false
        if !showSecretEye {
            rightView = customClearButton
            customClearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        }

        rightViewMode = .whileEditing

        addSubview(title)
        addSubview(messageLabel)
        addSubview(baseLineView)
    }

    fileprivate func maxTopInset() -> CGFloat {
        guard let font = self.font else {
            return 0.0
        }

        return max(0, floor(bounds.size.height - font.lineHeight - 4.0))
    }

    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }

        title.frame = CGRect(x: x,
                             y: title.frame.origin.y,
                             width: title.frame.size.width,
                             height: title.frame.size.height)

        messageLabel.textAlignment = textAlignment
        messageLabel.frame = CGRect(x: x,
                                    y: messageLabel.frame.origin.y,
                                    width: frame.size.width,
                                    height: messageLabel.frame.size.height)
        messageLabel.sizeToFit()
    }

    fileprivate func showTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur,
                       delay: 0,
                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
                       animations: {
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion: nil)
    }

    fileprivate func hideTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations: {
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion: nil)
    }

    func showError(withTitle title: String, animated: Bool) {
        let dur = animated ? animationDuration : 0

        messageLabel.text = title
        messageLabel.sizeToFit()
        messageLabel.textColor = errorTextColour
        baseLineView.backgroundColor = errorTextColour

        var labelFrame = messageLabel.frame
        labelFrame.origin.y = frame.size.height + 10
        messageLabel.frame = labelFrame
        textColor = errorTextColour
        let animations = { self.messageLabel.alpha = 1.0 }
        let options: UIView.AnimationOptions = [.beginFromCurrentState, .curveEaseOut]

        UIView.animate(withDuration: dur,
                       delay: 0,
                       options: options,
                       animations: animations,
                       completion: nil)

    }

    func hideError(animated: Bool) {
        if let hint = usedHint {
            showHint(withTitle: hint)
        }

        baseLineView.backgroundColor = baselineNormalColor
        textColor = defaultTextColor
        let animations = { self.messageLabel.alpha = 0.0 }
        let options: UIView.AnimationOptions = [.beginFromCurrentState, .curveEaseIn]
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur,
                       delay: 0,
                       options: options,
                       animations: animations,
                       completion: nil)
    }

    func showHint(withTitle title: String) {
        usedHint = title

        messageLabel.text = title
        messageLabel.sizeToFit()
        messageLabel.textColor = .darkGray
        var labelFrame = messageLabel.frame
        labelFrame.origin.y = frame.size.height + 10
        messageLabel.frame = labelFrame
        messageLabel.numberOfLines = 0
        messageLabel.alpha = 1.0
    }

    @objc func clearText() {
        text = .none
        sendActions(for: .editingChanged)
    }
}

extension FloatLabelTextField: InputValidation {
    var validationText: String? {
        let text: String?

        switch validationType {
        case .email, .fullname, .filled:
            text = self.text
        default:
            text = (self as? AKMaskField)?.digits ?? self.text
        }

        return text
    }

    func handleError(withMessage message: String) {
        let feedback = UIImpactFeedbackGenerator(style: .heavy)
        feedback.impactOccurred()
        showError(withTitle: message, animated: true)
    }

    func handleSuccess() {
        hideError(animated: true)
    }
}
