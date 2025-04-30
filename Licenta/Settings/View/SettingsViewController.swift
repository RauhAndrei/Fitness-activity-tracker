import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.separatorColor = .darkGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 52
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "SETTINGS"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backAction))
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Properties
    private let viewModel = SettingsViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        print("SettingsViewController loaded")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .black
        
        // Navigation Bar Setup
        navigationItem.titleView = navigationTitleLabel
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]
        navigationController?.navigationBar.barTintColor = .black
        
        // TableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showLogoutConfirmation() {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(
            title: "Logout",
            style: .destructive,
            handler: { [weak self] _ in
                self?.viewModel.handleAction(for: .logout)
            }
        ))
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource & Delegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.textProperties.color = .white
        content.image = UIImage(systemName: item.icon)
        content.imageProperties.tintColor = .white
        cell.contentConfiguration = content
        
        cell.backgroundColor = .black
        cell.accessoryType = .disclosureIndicator
        
        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronImageView.tintColor = .lightGray
        cell.accessoryView = chevronImageView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let label = UILabel()
        label.text = viewModel.sections[section].title
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        header.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(5)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let action = viewModel.sections[indexPath.section].items[indexPath.row].action
        
        print("Selected action: \(action)")
        
        switch action {
        case .accountSettings:
            print("Navigating to Account Settings")
            let vc = AccountSettingsViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case .notifications:
            print("Navigating to Notifications")
            let vc = NotificationViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case .fitnessProfile:
            print("Navigating to Fitness Profile")
            let vc = FitnessProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case .logout:
            print("Showing logout confirmation")
            showLogoutConfirmation()
        case .termsAndConditions:
            break
        case .contactUs:
            break
        }
    }
}



//import UIKit
//import SnapKit
//
//class SettingsViewController: UIViewController {
//
//    private let tableView = UITableView(frame: .zero, style: .grouped)
//
//    private let sections = [
//        (
//            title: "General",
//            items: [
//                (title: "Account settings", icon: "person.crop.circle"),
//                (title: "Notification", icon: "bell"),
//                (title: "Fitness profile", icon: "heart.fill")
//            ]
//        ),
//        (
//            title: "App",
//            items: [
//                (title: "Terms and conditions", icon: "doc.text"),
//                (title: "Contact us", icon: "envelope"),
//                (title: "Logout", icon: "arrow.backward.square.fill")
//            ]
//        )
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupConstraints()
//    }
//
//    private func setupUI() {
//        title = "SETTINGS"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.largeTitleTextAttributes = [
//            .foregroundColor: UIColor.white,
//            .font: UIFont.boldSystemFont(ofSize: 34)
//        ]
//
//        view.backgroundColor = .black
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.backgroundColor = .black
//        tableView.separatorColor = .darkGray
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
//        view.addSubview(tableView)
//    }
//
//    private func setupConstraints() {
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//}
//
//extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let item = sections[indexPath.section].items[indexPath.row]
//
//        // Configure cell
//        var content = cell.defaultContentConfiguration()
//        content.text = item.title
//        content.textProperties.color = .white
//        content.image = UIImage(systemName: item.icon)
//        content.imageProperties.tintColor = .white
//        cell.contentConfiguration = content
//
//        cell.backgroundColor = .black
//        cell.accessoryType = .disclosureIndicator
//        cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
//        cell.accessoryView?.tintColor = .lightGray
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        let label = UILabel()
//        label.text = sections[section].title
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 24)
//        header.addSubview(label)
//
//        label.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview()
//            make.top.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().inset(5)
//        }
//
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 52
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let item = sections[indexPath.section].items[indexPath.row]
//
//        // Handle navigation
//        switch item.title {
//        case "Account settings":
//            navigationController?.pushViewController(AccountSettingsViewController(), animated: true)
//        case "Notification":
//            navigationController?.pushViewController(NotificationViewController(), animated: true)
//        case "Logout":
//            showLogoutConfirmation()
//        default:
//            break
//        }
//    }
//
//    private func showLogoutConfirmation() {
//        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
//            // Handle logout
//        }))
//        present(alert, animated: true)
//    }
//}
