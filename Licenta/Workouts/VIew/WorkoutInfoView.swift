import UIKit
import SnapKit

// Custom view for workout info items
class WorkoutInfoView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        layer.cornerRadius = 10
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    func configure(title: String, value: String?, subtitle: String?) {
        titleLabel.text = title
        valueLabel.text = value
        subtitleLabel.text = subtitle
        
        valueLabel.isHidden = value == nil
        subtitleLabel.isHidden = subtitle == nil
        
        if value != nil {
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.centerY.equalToSuperview()
            }
        } else {
            titleLabel.snp.remakeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}
