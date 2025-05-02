import UIKit
import SnapKit

class GoalsView: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: - Properties
    private let goals: [(title: String, subtitle: String)] = [
        ("Build strength", "Get stronger with ease exercises"),
        ("Build muscle", "Building muscle through sentence progression"),
        ("Lose fat", "Fat burning workout"),
        ("Learn technic", "Master basic to advanced skills")
    ]
    
    private var optionViews: [GoalOptionView] = []
    private(set) var selectedIndex: Int?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func getSelectedIndex() -> Int? {
        return selectedIndex
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .black
        
        titleLabel.text = "Goals"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "Choose as much as you want"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        for (index, goal) in goals.enumerated() {
            let optionView = GoalOptionView(title: goal.title, subtitle: goal.subtitle)
            optionView.tag = index
            optionView.onTap = { [weak self] in
                self?.selectOption(at: index)
            }
            optionViews.append(optionView)
            stackView.addArrangedSubview(optionView)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
    
    private func selectOption(at index: Int) {
        selectedIndex = index
        for (i, view) in optionViews.enumerated() {
            view.setSelected(i == index)
        }
        
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

class GoalOptionView: UIView {
    
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
            self.highlightOverlay.alpha = selected ? 1 : 0
            self.containerView.layer.borderColor = selected ? UIColor.systemBlue.cgColor : UIColor.gray.cgColor
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
