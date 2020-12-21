import UIKit
import SnapKit

class MarketMetricView: UIView {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ""
        return formatter
    }()

    static let width: CGFloat = 78

    private let titleLabel = UILabel()
    private let gradientBar = GradientPercentBar()
    private let valueLabel = UILabel()
    private let diffLabel = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview()
        }

        titleLabel.font = .micro
        titleLabel.textColor = .themeGray

        addSubview(gradientBar)
        gradientBar.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.margin6)
            maker.width.equalTo(GradientPercentBar.width)
            maker.height.equalTo(GradientPercentBar.height)
        }

        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(gradientBar.snp.trailing).offset(CGFloat.margin12)
            maker.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.margin6)
            maker.trailing.equalToSuperview()
        }

        valueLabel.font = .subhead2
        valueLabel.textColor = .themeBran

        addSubview(diffLabel)
        diffLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(gradientBar.snp.trailing).offset(CGFloat.margin12)
            maker.top.equalTo(valueLabel.snp.bottom).offset(CGFloat.margin2)
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }

        diffLabel.font = .caption
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MarketMetricView {

    public func set(title: String?, value: String?, diff: Decimal?) {
        titleLabel.text = title
        valueLabel.text = value

        guard let diff = diff else {
            diffLabel.text = nil
            gradientBar.set(value: nil)

            return
        }

        gradientBar.set(value: diff)
        //todo: extract
        let sign = diff >= 0 ? "+" : "-"

        let formattedDiff = Self.formatter.string(from: abs(diff * 100) as NSNumber)
        let diffString = formattedDiff.map { sign + $0 + "%" }

        diffLabel.text = diffString
        diffLabel.textColor = diff >= 0 ? .themeRemus : .themeLucian
    }

}
