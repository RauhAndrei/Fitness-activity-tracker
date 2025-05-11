import UIKit
import SnapKit

class FitnessLevelOptionView: UIView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let selectionImageView = UIImageView()
    private let highlightOverlay = UIView()

    var onTap: (() -> Void)?
    
    private var isSelectedOption: Bool = false {
        didSet {
            animateSelectionChange(isSelectedOption)
        }
    }

    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        setupUI(title: title, subtitle: subtitle)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSelected(_ selected: Bool) {
        isSelectedOption = selected
    }
    
    private func setupUI(title: String, subtitle: String) {
        backgroundColor = .clear
        
        containerView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.clipsToBounds = true
        addSubview(containerView)
        
        highlightOverlay.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        highlightOverlay.alpha = 0
        highlightOverlay.layer.cornerRadius = 15
        containerView.insertSubview(highlightOverlay, at: 0)

        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        containerView.addSubview(titleLabel)
        
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.numberOfLines = 0
        containerView.addSubview(subtitleLabel)
        
        selectionImageView.tintColor = .white
        selectionImageView.image = UIImage(systemName: "circle")
        containerView.addSubview(selectionImageView)
        
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        highlightOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectionImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualTo(selectionImageView.snp.leading).offset(-12)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(selectionImageView.snp.leading).offset(-12)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    private func animateSelectionChange(_ selected: Bool) {
        let imageName = selected ? "largecircle.fill.circle" : "circle"
        selectionImageView.image = UIImage(systemName: imageName)
        
        UIView.animate(withDuration: 0.2) {
//            self.highlightOverlay.alpha = selected ? 1 : 0
//            self.containerView.layer.borderColor = selected ? UIColor.systemBlue.cgColor : UIColor.gray.cgColor
            self.containerView.transform = selected ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
        }
        
        if selected {
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

    @objc private func didTap() {
        onTap?()
    }
    
    
    
    
}
