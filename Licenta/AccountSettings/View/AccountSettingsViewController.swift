import UIKit
import SnapKit

class AccountSettingsViewController: UIViewController {

    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView = UIView()
    private var fieldLabels = [UILabel]()
    private var textFields = [UITextField]()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - ViewModel
    private let viewModel = AccountSettingsViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModelBindings()
        setupKeyboardDismissGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTextFieldValues()
    }

    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .black
        setupNavigationBar()
        setupScrollView()
        setupFormFields()
        registerForKeyboardNotifications()
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
        navigationItem.leftBarButtonItem?.tintColor = .white

        let titleLabel = UILabel()
        titleLabel.text = "ACCOUNT SETTINGS"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        navigationItem.titleView = titleLabel

        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
    }

    private func setupFormFields() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4) // SPACING MAI MIC
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        for (index, field) in viewModel.model.fields.enumerated() {
            let label = createLabel(text: field.label)
            let textField = createTextField(placeholder: field.placeholder)
            textField.tag = index

            fieldLabels.append(label)
            textFields.append(textField)
            contentView.addSubview(label)
            contentView.addSubview(textField)
        }

        contentView.addSubview(saveButton)
        setupConstraints()
    }

    private func setupConstraints() {
        var previousView: UIView = profileImageView

        for (index, label) in fieldLabels.enumerated() {
            label.snp.makeConstraints { make in
                make.top.equalTo(previousView.snp.bottom).offset(index == 0 ? 12 : 16)
                make.leading.trailing.equalToSuperview().inset(20)
            }

            let textField = textFields[index]
            textField.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(4)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(44)
            }

            previousView = textField
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(previousView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    private func setupViewModelBindings() {
        viewModel.didUpdateModel = { [weak self] in
            self?.updateTextFieldValues()
        }

        viewModel.showAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
    }

    // MARK: - Helpers
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.systemGray]
        )

        return textField
    }

    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }

    private func updateTextFieldValues() {
        for (index, field) in viewModel.model.fields.enumerated() {
            textFields[index].text = field.value
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    private func setupKeyboardDismissGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Keyboard Handling
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            scrollView.contentInset.bottom = keyboardFrame.height + 10
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
    }

    // MARK: - Actions
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.updateField(at: textField.tag, with: textField.text ?? "")
    }

    @objc private func saveButtonTapped() {
        view.endEditing(true)
        viewModel.saveChanges()
    }
}

// MARK: - UITextFieldDelegate
extension AccountSettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}






//import UIKit
//import SnapKit
//
//class VIew: UIViewController {
//
//    // MARK: - UI Elements
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "MY ACCOUNT"
//        label.font = UIFont.boldSystemFont(ofSize: 24)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Farell"
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let levelLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Beginner / Build strength"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .gray
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let scheduleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Shedule"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let currentStreakLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Current streak"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let longestStreakLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Longest streak"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let currentStreakValueLabel: UILabel = {
//        let label = UILabel()
//        label.text = "86 days"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let longestStreakValueLabel: UILabel = {
//        let label = UILabel()
//        label.text = "270 days"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let performanceTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Today's Performance"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let performanceValueLabel: UILabel = {
//        let label = UILabel()
//        label.text = "50%"
//        label.font = UIFont.boldSystemFont(ofSize: 32)
//        label.textAlignment = .center
//        return label
//    }()
//
//    private let tabBarView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemGray6
//        return view
//    }()
//
//    private let chatButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Chat", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        return button
//    }()
//
//    private let workoutButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Workout", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        return button
//    }()
//
//    private let accountButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Account", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        return button
//    }()
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//        setupConstraints()
//    }
//
//    // MARK: - Setup
//
//    private func setupUI() {
//        view.addSubview(titleLabel)
//        view.addSubview(nameLabel)
//        view.addSubview(levelLabel)
//        view.addSubview(scheduleLabel)
//
//        view.addSubview(currentStreakLabel)
//        view.addSubview(longestStreakLabel)
//        view.addSubview(currentStreakValueLabel)
//        view.addSubview(longestStreakValueLabel)
//
//        view.addSubview(performanceTitleLabel)
//        view.addSubview(performanceValueLabel)
//
//        view.addSubview(tabBarView)
//        tabBarView.addSubview(chatButton)
//        tabBarView.addSubview(workoutButton)
//        tabBarView.addSubview(accountButton)
//    }
//
//    private func setupConstraints() {
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.centerX.equalToSuperview()
//        }
//
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//        }
//
//        levelLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(8)
//            make.centerX.equalToSuperview()
//        }
//
//        scheduleLabel.snp.makeConstraints { make in
//            make.top.equalTo(levelLabel.snp.bottom).offset(30)
//            make.centerX.equalToSuperview()
//        }
//
//        currentStreakLabel.snp.makeConstraints { make in
//            make.top.equalTo(scheduleLabel.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(40)
//        }
//
//        longestStreakLabel.snp.makeConstraints { make in
//            make.top.equalTo(currentStreakLabel)
//            make.trailing.equalToSuperview().offset(-40)
//        }
//
//        currentStreakValueLabel.snp.makeConstraints { make in
//            make.top.equalTo(currentStreakLabel.snp.bottom).offset(8)
//            make.centerX.equalTo(currentStreakLabel)
//        }
//
//        longestStreakValueLabel.snp.makeConstraints { make in
//            make.top.equalTo(longestStreakLabel.snp.bottom).offset(8)
//            make.centerX.equalTo(longestStreakLabel)
//        }
//
//        performanceTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(currentStreakValueLabel.snp.bottom).offset(40)
//            make.centerX.equalToSuperview()
//        }
//
//        performanceValueLabel.snp.makeConstraints { make in
//            make.top.equalTo(performanceTitleLabel.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//        }
//
//        tabBarView.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(80)
//        }
//
//        chatButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.centerY.equalToSuperview()
//        }
//
//        workoutButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
//
//        accountButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalToSuperview()
//        }
//    }
//}
