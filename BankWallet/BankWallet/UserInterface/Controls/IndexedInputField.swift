import UIKit
import SnapKit

@IBDesignable
class IndexedInputField: UIView, UITextFieldDelegate {
    private let textFont = UIFont.appBody

    var textField: UITextField
    var indexLabel: UILabel

    var clearTextButton = UIButton.appSecondary

    var onReturn: (() -> ())?
    var onSpaceKey: (() -> Bool)?
    var onTextChange: ((String?) -> ())?

    override init(frame: CGRect) {
        indexLabel = UILabel()
        textField = UITextField()

        clearTextButton.setImage(UIImage(named: "Send Delete Icon")?.tinted(with: .appOz), for: .normal)
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        backgroundColor = .appLawrence


        addSubview(clearTextButton)
        clearTextButton.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().inset(CGFloat.margin2x)
            maker.size.equalTo(CGFloat.heightButtonSecondary)
        }

        clearTextButton.addTarget(self, action: #selector(onClearText), for: .touchUpInside)
        clearTextButton.isHidden = true

        addSubview(indexLabel)
        indexLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(CGFloat.margin3x)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(26)
        }
        indexLabel.textColor = .appGray50
        indexLabel.font = textFont

        textField.keyboardAppearance = App.theme.keyboardAppearance
        textField.autocorrectionType = .yes
        textField.autocapitalizationType = .none
        textField.tintColor = AppTheme.textFieldTintColor
        textField.font = textFont

        textField.addTarget(self, action: #selector(textChange), for: .editingChanged)
        textField.textColor = .appOz
        textField.delegate = self
        addSubview(textField)
        textField.snp.makeConstraints { maker in
            maker.leading.equalTo(self.indexLabel.snp.trailing)
            maker.top.bottom.equalToSuperview().inset(CGFloat.margin3x)
            maker.trailing.equalTo(self.clearTextButton.snp.leading).inset(CGFloat.margin3x)
            maker.height.equalTo(textFont.lineHeight)
        }
    }

    @objc func onClearText() {
        textField.text = nil
        clearTextButton.isHidden = true
    }

    @objc func textChange(textField: UITextField) {
        clearTextButton.isHidden = textField.text?.isEmpty ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearTextButton.isHidden = textField.text?.isEmpty ?? true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturn?()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        onTextChange?(textField.text)
        clearTextButton.isHidden = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case " ":
            return onSpaceKey?() ?? true
        default:
            return true
        }
    }
}
