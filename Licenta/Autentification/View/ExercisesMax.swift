import UIKit
import SnapKit

class ExercisesMax: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let tableView = UITableView()
    
    // MARK: - Properties
    private let options = ["<10", "10-30", "30-50", "50+"]
    var selectedIndex: Int?
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
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
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
        titleLabel.backgroundColor = .clear
        addSubview(titleLabel)
    }
    
    private func setupSubTitleLabel() {
        subTitleLabel.text = "How many can you do without interruption?"
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.textColor = .white
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.backgroundColor = .clear
        subTitleLabel.lineBreakMode = .byWordWrapping
        addSubview(subTitleLabel)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        tableView.separatorColor = .darkGray
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(30)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat(options.count * 50))
            make.bottom.lessThanOrEqualToSuperview().offset(-20).priority(.low)
        }
    }
    
    // MARK: - Public Methods
    func setSelectedIndex(_ index: Int?) {
        selectedIndex = index
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ExercisesMax: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        cell.selectionStyle = .none
        cell.accessoryType = (selectedIndex == indexPath.row) ? .checkmark : .none
        cell.tintColor = .systemBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
        
        // Notify viewModel if available
        viewModel?.updateSelectedIndex(for: indexPath.row, at: currentPageIndex)
        
        // Or use the closure
        selectionHandler?(indexPath.row)
    }
}
