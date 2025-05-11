import UIKit
import SnapKit

class ExerciseOptionCell: UITableViewCell {
    static let identifier = "ExerciseOptionCell"
    
    private let containerView = UIView()
    private let optionLabel = UILabel()
    private let radioButton = UIButton()
    private let selectionIndicator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        // Container View
        containerView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor // Default border color is gray
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)
        
        // Option Label
        optionLabel.textColor = .white
        optionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        optionLabel.textAlignment = .left
        containerView.addSubview(optionLabel)
        
        // Radio Button
        radioButton.tintColor = .white
        radioButton.isUserInteractionEnabled = false
        containerView.addSubview(radioButton)
        
        // Selection Indicator (for animation)
//        selectionIndicator.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        selectionIndicator.alpha = 0
        selectionIndicator.layer.cornerRadius = 15
        containerView.insertSubview(selectionIndicator, at: 0)
        
        // Constraints for containerView to make sure it doesn't exceed the screen edges
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)) // Adds proper padding
        }
        
        // Constraints for optionLabel
        optionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        // Constraints for radioButton
        radioButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        // Constraints for selectionIndicator
        selectionIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with option: String, isSelected: Bool) {
        optionLabel.text = option

        let imageName = isSelected ? "largecircle.fill.circle" : "circle"
        radioButton.setImage(UIImage(systemName: imageName), for: .normal)

        UIView.animate(withDuration: 0.2) {
            self.containerView.transform = isSelected ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
        }

        if isSelected {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.6,
                           options: [.curveEaseOut],
                           animations: {
                self.containerView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.containerView.transform = .identity
                }
            }
        }
    }
    
    

}
