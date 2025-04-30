import UIKit
import SnapKit

class NotificationViewController: UIViewController {
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .darkGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return tableView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NOTIFICATION"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
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
    private let viewModel = NotificationViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .black
        
        // Configure navigation bar
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .white  // Buton back alb
        navigationItem.titleView = titleLabel
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action Methods
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        viewModel.toggleNotification(at: sender.tag)
    }
}

// MARK: - UITableViewDataSource & Delegate
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .main(let items) = viewModel.sections[section] else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case .main(let items) = viewModel.sections[indexPath.section] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure cell content
        cell.textLabel?.text = items[indexPath.row].title
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        
        // Configure switch
        let notificationSwitch = UISwitch()
        notificationSwitch.isOn = items[indexPath.row].isEnabled
        notificationSwitch.onTintColor = .white
        notificationSwitch.thumbTintColor = .black
        notificationSwitch.backgroundColor = .white
        notificationSwitch.layer.cornerRadius = notificationSwitch.frame.height / 2
        notificationSwitch.tag = indexPath.row
        notificationSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        cell.accessoryView = notificationSwitch
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}














//import UIKit
//import SnapKit
//
//class NotificationViewController: UIViewController {
//
//    private let tableView = UITableView(frame: .zero, style: .grouped)
//    private let titleLabel = UILabel()
//
//    private let notifications = [
//        "Send workout notification",
//        "Send ad notification",
//        "Enable sounds"
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupConstraints()
//    }
//
//    private func setupUI() {
//        // Configurare navbar - ascunde textul "Back" și pune doar săgeata
//        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
//                                         style: .plain,
//                                         target: self,
//                                         action: #selector(backAction))
//        backButton.tintColor = .white
//        navigationItem.leftBarButtonItem = backButton
//
//        // Titlul centrat custom
//        titleLabel.text = "NOTIFICATION"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        titleLabel.textColor = .white
//        titleLabel.textAlignment = .center
//        navigationItem.titleView = titleLabel
//
//        // TableView
//        view.backgroundColor = .black
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.backgroundColor = .clear
//        tableView.separatorColor = .darkGray
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
//        view.addSubview(tableView)
//    }
//
//    private func setupConstraints() {
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(-10)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//
//    @objc private func backAction() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notifications.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = notifications[indexPath.row]
//        cell.textLabel?.textColor = .white
//        cell.backgroundColor = .black
//
//        // Adăugăm switch-uri
//        let switchView = UISwitch()
//        switchView.isOn = true
//        switchView.onTintColor = .systemBlue
//        cell.accessoryView = switchView
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//}
