//
//  PasswordToggleView.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

@IBDesignable class PasswordToggleView: UIView {

    // MARK: - Outlets
    @IBOutlet private weak var toggleImageView: UIImageView?

    // MARK: - Properties
    private var view: UIView?
    private let showPassImage = UIImage(named: "hide-password")?.resizeImage()
    private let hidePassImage = UIImage(named: "see-password")?.resizeImage()
    private var isShowingPassword: Bool = false
    var textField: UITextField?

    override init(frame: CGRect) {

        super.init(frame: frame)

        xibSetup()
    }

    // MARK: - Actions
    @IBAction func toggleButtonPressed(_ sender: Any) {

        isShowingPassword = !isShowingPassword
        textField?.isSecureTextEntry = !isShowingPassword

        toggleImageView?.image = isShowingPassword ? hidePassImage : showPassImage
    }

    // MARK: - Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        xibSetup()
    }

    init(frame: CGRect, completion : @escaping (Bool) -> Void) {
        super.init(frame: frame)
        xibSetup()
    }

    fileprivate func xibSetup() {
        guard let viewLoaded = loadViewFromNib() else { return }

        viewLoaded.frame = bounds
        viewLoaded.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(viewLoaded)

        view = viewLoaded
        view?.backgroundColor = .clear
        toggleImageView?.image = showPassImage
        toggleImageView?.tintColor = .black
    }

    fileprivate func loadViewFromNib() -> UIView? {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PasswordToggleView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView

        return view
    }
}
