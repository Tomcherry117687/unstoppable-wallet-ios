import UIKit
import ActionSheet

class AppTheme {
    static var textFieldTintColor: UIColor { .appJacob }

    public static let defaultAnimationDuration = 0.3

    static var actionSheetBackgroundColor: UIColor { .appLawrence }
    static var controllerBackgroundFromGradient: UIColor { .appTyler }
    static var controllerBackgroundToGradient: UIColor { .appHelsing }
    static let tabBarSeparatorColor: UIColor = .appSteel20
    static var navigationBarTintColor: UIColor = .appJacob
    static var navigationBarBackgroundColor: UIColor { UIColor.appTyler.withAlphaComponent(0.96) }

    static var actionSheetConfig: ActionSheetThemeConfig {
        get {
            ActionSheetThemeConfig(
                    actionStyle: .sheet(showDismiss: false),
                    topMargin: 0,
                    cornerRadius: 16,
                    separatorColor: .appSteel20,
                    backgroundStyle: .color(color: .appBlack50)
            )
        }
    }
    static let viewMargin: CGFloat = 16

    static let alertSmallMargin: CGFloat = 8
    static let alertMediumMargin: CGFloat = 12
    static let alertBigMargin: CGFloat = 20

    static var alertBackgroundColor: UIColor { .appLawrence }
    static let alertHeaderHeight: CGFloat = 40
    static let alertHeaderFont: UIFont = .appSubhead1
    static let alertHeaderColor: UIColor = .appGray

    static let alertTitleHeight: CGFloat = 62
    static let alertTitleFont: UIFont = .appHeadline2
    static var alertTitleColor: UIColor { .appOz }
    static let alertSubtitleTopMargin: CGFloat = 3
    static var alertSubtitleFont: UIFont = .appSubhead2
    static var alertSubtitleColor: UIColor  = .appGray

    static let alertTextMargin: CGFloat = 16
    static let alertTextFont: UIFont = .appSubhead1
    static var alertTextColor: UIColor = .appGray

    static let footerTextMargin: CGFloat = 16
    static let footerTextColor: UIColor = .appGray
    static let footerTextFont: UIFont = .appSubhead2

    static let alertCellHeight: CGFloat = 53
    static let alertCellFont: UIFont = .appHeadline2
    static let alertMessageFont: UIFont = .appSubhead1
    static var alertCellHighlightColor: UIColor = .appJacob
    static var alertMessageDefaultColor: UIColor { .appOz }

    static let alertSideMargin: CGFloat = 61
    static var alertConfig: ActionSheetThemeConfig {
        ActionSheetThemeConfig(
                actionStyle: .alert,
                sideMargin: AppTheme.alertSideMargin,
                cornerRadius: 16,
                separatorColor: .appSteel20,
                backgroundStyle: .color(color: .appBlack50)
        )
    }

    static let coinIconColor: UIColor = .appGray
    static let coinIconSize: CGFloat = 24

    static let textPlaceholderColor: UIColor = .appGray50

    static let progressStepsCount = 3

    static func updateNavigationBarTheme() {
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = AppTheme.navigationBarBackgroundColor
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.appOz]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.appOz]

            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        }
    }

}

extension UIFont {
    static let appTitle1: UIFont = .systemFont(ofSize: 40, weight: .bold)
    static let appTitle2: UIFont = .systemFont(ofSize: 34, weight: .bold)
    static let appTitle2R: UIFont = .systemFont(ofSize: 34, weight: .regular)
    static let appTitle3: UIFont = .systemFont(ofSize: 22, weight: .bold)
    static let appHeadline1: UIFont = .systemFont(ofSize: 22, weight: .semibold)
    static let appHeadline2: UIFont = .systemFont(ofSize: 17, weight: .semibold)
    static let appBody: UIFont = .systemFont(ofSize: 17, weight: .regular)
    static let appSubhead1: UIFont = .systemFont(ofSize: 14, weight: .medium)
    static let appSubhead1I: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium).with(traits: .traitItalic)
    static let appSubhead2: UIFont = .systemFont(ofSize: 14, weight: .regular)
    static let appCaption: UIFont = .systemFont(ofSize: 12, weight: .regular)
    static let appCaptionSB: UIFont = .systemFont(ofSize: 12, weight: .semibold)
    static let appMicro: UIFont = .systemFont(ofSize: 10, weight: .regular)
    static let appMicroSB: UIFont = .systemFont(ofSize: 10, weight: .semibold)
}

extension CGFloat {
    static let cornerRadius2: CGFloat = 2
    static let cornerRadius4: CGFloat = 4
    static let cornerRadius8: CGFloat = 8
    static let cornerRadius12: CGFloat = 12
    static let cornerRadius16: CGFloat = 16

    static let margin05x: CGFloat = 2
    static let margin1x: CGFloat = 4
    static let margin2x: CGFloat = 8
    static let margin3x: CGFloat = 12
    static let margin4x: CGFloat = 16
    static let margin6x: CGFloat = 24
    static let margin8x: CGFloat = 32
    static let margin10x: CGFloat = 40
    static let margin12x: CGFloat = 48

    static let marginButtonSide: CGFloat = 44

    static let marginTextSide: CGFloat = 44

    static let heightOnePixel: CGFloat = 1 / UIScreen.main.scale
    static let heightOneDp: CGFloat = 1
    static let heightSingleLineCell: CGFloat = 44
    static let heightDoubleLineCell: CGFloat = 60
    static let heightSingleLineInput: CGFloat = 44
    static let heightDoubleLineInput: CGFloat = 66
    static let heightButton: CGFloat = 50
    static let heightButtonSecondary: CGFloat = 32
    static let heightBottomWrapperBar: CGFloat = 126
}

extension UIButton {

    static var appYellow: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .appHeadline2
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.appGray50, for: .disabled)
        button.setBackgroundColor(color: .appJacob, gradient: (colors: [UIColor(white: 1, alpha: 0.4), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .appJacob, forState: .highlighted)
        button.setBackgroundColor(color: .appSteel20, forState: .disabled)
        button.cornerRadius = .cornerRadius8

        return button
    }

    static var appGreen: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .appHeadline2
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.appGray50, for: .disabled)
        button.setBackgroundColor(color: .appRemus, gradient: (colors: [UIColor(white: 1, alpha: 0.4), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .appRemus, forState: .highlighted)
        button.setBackgroundColor(color: .appSteel20, forState: .disabled)
        button.cornerRadius = .cornerRadius8

        return button
    }

    static var appRed: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .appHeadline2
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.appGray50, for: .disabled)
        button.setBackgroundColor(color: .appLucian, gradient: (colors: [UIColor(white: 1, alpha: 0.4), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .appLucian, forState: .highlighted)
        button.setBackgroundColor(color: .appSteel20, forState: .disabled)
        button.cornerRadius = .cornerRadius8

        return button
    }

    static var appGray: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .appHeadline2
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.appGray50, for: .disabled)
        button.setBackgroundColor(color: .appLightGray, gradient: (colors: [UIColor(white: 1, alpha: 1), UIColor(white: 1, alpha: 0)], height: .heightButton), forState: .normal)
        button.setBackgroundColor(color: .appLightGray, forState: .highlighted)
        button.setBackgroundColor(color: .appSteel20, forState: .disabled)
        button.cornerRadius = .cornerRadius8

        return button
    }

    static var appSecondary: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .appSubhead1
        button.setTitleColor(.appOz, for: .normal)
        button.setTitleColor(.appGray50, for: .disabled)
        button.setBackgroundColor(color: .appElena, gradient: (colors: [UIColor(white: 1, alpha: App.theme.alphaSecondaryButtonGradient), UIColor(white: 1, alpha: 0)], height: .heightButtonSecondary), forState: .normal)
        button.setBackgroundColor(color: .appElena, forState: .highlighted)
        button.setBackgroundColor(color: .appJeremy, forState: .disabled)
        button.cornerRadius = .cornerRadius4
        button.borderColor = .appSteel20
        button.borderWidth = 1
        button.contentEdgeInsets.left = .margin2x
        button.contentEdgeInsets.right = .margin2x

        return button
    }

    static var appTertiary: UIButton {
        let button = UIButton()

        button.titleLabel?.font = .appHeadline2
        button.setTitleColor(.appLeah, for: .normal)
        button.setTitleColor(.appGray50, for: .highlighted)
        button.setTitleColor(.appGray50, for: .disabled)
        button.setBackgroundColor(color: .clear, forState: .normal)
        button.contentEdgeInsets.left = .margin2x
        button.contentEdgeInsets.right = .margin2x

        return button
    }

}

extension TimeInterval {
    static let defaultAnimationDuration: TimeInterval = 0.3
}
