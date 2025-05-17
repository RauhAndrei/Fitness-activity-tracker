import UIKit
import SnapKit

class FitnessLevelView: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: - Properties
    private let levels: [(title: String, subtitle: String)] = [
        ("Beginner", "Some experience"),
        ("Intermediate", "Experience with consistent training"),
        ("Advanced", "Consistent training like pro")
    ]
    
    private var optionViews: [FitnessLevelOptionView] = []
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
        
        titleLabel.text = "Fitness Level"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        for (index, level) in levels.enumerated() {
            let optionView = FitnessLevelOptionView(title: level.title, subtitle: level.subtitle)
            optionView.tag = index
            optionView.onTap = { [weak self] in
                self?.selectOption(at: index)
            }
            optionViews.append(optionView)
            stackView.addArrangedSubview(optionView)
        }
        
        setupConstraints()
        selectOption(at: 0) // <- selecția implicită
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
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
