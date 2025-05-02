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
        tableView.register(ExerciseOptionCell.self, forCellReuseIdentifier: ExerciseOptionCell.identifier)
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

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ExercisesMax: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseOptionCell.identifier, for: indexPath) as? ExerciseOptionCell else {
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
