import UIKit
import SnapKit

class MarketMetricLargeView: UIView {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ""
        return formatter
    }()

    private let titleLabel = UILabel()
    private let gradientCircle = GradientPercentCircle()
    private let valueLabel = UILabel()
    private let diffLabel = UILabel()

    init() {
        super.init(frame: .zero)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.leading.top.trailing.equalToSuperview()
        }

        titleLabel.numberOfLines = 2
        titleLabel.font = .micro
        titleLabel.textColor = .themeGray

        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.margin12)
        }

        valueLabel.font = .headline1
        valueLabel.textColor = .themeLeah
        valueLabel.adjustsFontSizeToFitWidth = true

        addSubview(gradientCircle)
        gradientCircle.snp.makeConstraints { maker in
            maker.leading.bottom.equalToSuperview()
//            maker.top.equalTo(valueLabel.snp.bottom).offset(10)
            maker.width.equalTo(GradientPercentCircle.width)
            maker.height.equalTo(GradientPercentCircle.height)
        }

        addSubview(diffLabel)
        diffLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(valueLabel.snp.bottom).offset(CGFloat.margin32)
            maker.bottom.equalToSuperview().inset(CGFloat.margin16)
        }

        diffLabel.font = .body
        diffLabel.textAlignment = .center
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MarketMetricLargeView {

    public func set(title: String?, value: String?, diff: Decimal?) {
        titleLabel.text = title
        valueLabel.text = value

        guard let diff = diff else {
            diffLabel.text = nil
            gradientCircle.set(value: nil)

            return
        }

        gradientCircle.set(value: diff.cgFloatValue)
        let sign = diff >= 0 ? "+" : "-"

        let formattedDiff = Self.formatter.string(from: abs(diff * 100) as NSNumber)
        let diffString = formattedDiff.map { sign + $0 + "%" }

        diffLabel.text = diffString
        diffLabel.textColor = diff >= 0 ? .themeRemus : .themeLucian
    }

}
