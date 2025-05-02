import UIKit
import SnapKit

class GenderButton: UIButton {

    let symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 60)
        label.textAlignment = .center
        return label
    }()

    let customTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    let title: String

    init(symbol: String, title: String) {
        self.title = title
        super.init(frame: .zero)
        setupUI(symbol: symbol, title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
            backgroundColor = isSelected ? UIColor(white: 0.2, alpha: 1) : UIColor(white: 0.1, alpha: 1)
        }
    }

    private func setupUI(symbol: String, title: String) {
        layer.cornerRadius = 100
        clipsToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = UIColor(white: 0.1, alpha: 1)

        symbolLabel.text = symbol
        customTitleLabel.text = title

        addSubview(symbolLabel)
        addSubview(customTitleLabel)

        symbolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70)
        }

        customTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}
