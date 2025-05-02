import UIKit
import SnapKit

class GenderSelectionView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let maleButton = GenderButton(symbol: "♂", title: "Male")
    private let femaleButton = GenderButton(symbol: "♀", title: "Female")
    private var selectedButton: GenderButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .black

        addSubview(titleLabel)
        addSubview(maleButton)
        addSubview(femaleButton)

        maleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(110)
            make.centerX.equalToSuperview()
        }

        maleButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }

        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

    @objc private func buttonTapped(_ sender: GenderButton) {
        selectedButton?.isSelected = false
        sender.isSelected = true
        selectedButton = sender
    }

    func getSelectedGender() -> String? {
        return selectedButton?.title
    }
}
