import UIKit
import SnapKit

class ExercisesMax: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let tableView = UITableView()
    
    // MARK: - Properties
    private let options = ["<10", "10-30", "30-50", ">50"]
    private var selectedIndex: Int?
    var currentPageIndex: Int = 0
    weak var viewModel: CreateAccountViewModel?
    var selectionHandler: ((Int) -> Void)?
    
    // MARK: - Initialization
    init(title: String, viewModel: CreateAccountViewModel? = nil, pageIndex: Int = 0) {
        self.viewModel = viewModel
        self.currentPageIndex = pageIndex
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .black
        setupTitleLabel()
        setupSubTitleLabel()
        setupTableView()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    private func setupSubTitleLabel() {
        subTitleLabel.text = "How many can you do without interruption?"
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.textColor = .white
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        addSubview(subTitleLabel)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExerciseOptionCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(CGFloat(options.count * 70)) // Increased height for better spacing
        }
    }
}

// MARK: - Custom Cell Class
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
        containerView.layer.borderColor = UIColor.gray.cgColor
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
        selectionIndicator.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        selectionIndicator.alpha = 0
        selectionIndicator.layer.cornerRadius = 15
        containerView.insertSubview(selectionIndicator, at: 0)
        
        // Constraints
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        }
        
        optionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        radioButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        selectionIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with option: String, isSelected: Bool) {
        optionLabel.text = option
        
        let imageName = isSelected ? "largecircle.fill.circle" : "circle"
        radioButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        // Animate selection change
        UIView.animate(withDuration: 0.2) {
            self.selectionIndicator.alpha = isSelected ? 1 : 0
            self.containerView.layer.borderColor = isSelected ? UIColor.systemTeal.cgColor : UIColor.gray.cgColor
            self.containerView.transform = isSelected ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
        }
        
        // Add subtle pulse animation when selected
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

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ExercisesMax: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExerciseOptionCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: options[indexPath.row], isSelected: selectedIndex == indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // Increased height for better spacing
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSelection(newIndex: indexPath.row)
        
        // Provide haptic feedback
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    private func updateSelection(newIndex: Int) {
        // Create index paths for reloading
        var indexPathsToReload = [IndexPath(row: newIndex, section: 0)]
        
        // If there was a previous selection, add it to reload list
        if let prevSelected = selectedIndex, prevSelected != newIndex {
            indexPathsToReload.append(IndexPath(row: prevSelected, section: 0))
        }
        
        // Update the selected index
        selectedIndex = newIndex
        
        // Reload with nice animation
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        
        // Notify the selection handler
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.selectionHandler?(newIndex)
        }
    }
}
