import UIKit
import SnapKit

class GenderSelectionView: UIView {
    
    private let titleLabel = UILabel()
    private let maleButton = UIButton()
    private let femaleButton = UIButton()
    private var selectedButton: UIButton?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure title
        titleLabel.text = "Gender"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        // Configure buttons
        let buttonHeight: CGFloat = 50
        let cornerRadius: CGFloat = 10
        
        maleButton.setTitle("Male", for: .normal)
        femaleButton.setTitle("Female", for: .normal)
        
        [maleButton, femaleButton].forEach { button in
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            button.layer.cornerRadius = cornerRadius
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(maleButton)
        addSubview(femaleButton)
        
        // Setup constraints
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(4)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedButton?.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        sender.backgroundColor = .systemBlue
        selectedButton = sender
    }
    
    func getSelectedGender() -> String? {
        return selectedButton?.titleLabel?.text
    }
}
