import UIKit
import SnapKit

class FitnessProfileViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var fieldLabels = [UILabel]()
    private var textFields = [UITextField]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FITNESS PROFILE"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
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
    private let viewModel = FitnessProfileViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        setupViewModelBindings()
    }
    
    // MARK: - Setup
    private func setupView() {
        setupNavigation()
        setupScrollView()
        setupFormFields()
    }
    
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = titleLabel
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview().priority(.low) // adăugat!
        }
    }
    
    private func setupFormFields() {
        // Eliminat: contentView.addSubview(titleLabel) ❌

        for (index, field) in viewModel.model.fields.enumerated() {
            let label = createLabel(text: field.label)
            let textField = createInputField(placeholder: field.placeholder)
            textField.tag = index
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            fieldLabels.append(label)
            textFields.append(textField)
            contentView.addSubview(label)
            contentView.addSubview(textField)
        }
        
        contentView.addSubview(saveButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        var previousView: UIView = contentView
        
        for (index, label) in fieldLabels.enumerated() {
            label.snp.makeConstraints { make in
                make.top.equalTo(index == 0 ? contentView.snp.top : previousView.snp.bottom).offset(index == 0 ? 20 : 30)
                make.leading.equalToSuperview().offset(20)
            }
            
            let textField = textFields[index]
            textField.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(5)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(50)
            }
            
            previousView = textField
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(previousView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func setupViewModelBindings() {
        viewModel.didUpdateModel = { [weak self] in
            // Poți actualiza UI-ul aici dacă este necesar
        }
        
        viewModel.showAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
    }
    
    // MARK: - UI Helpers
    private func createInputField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.updateField(at: textField.tag, with: textField.text ?? "")
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        viewModel.saveChanges()
    }
}




//import UIKit
//import SnapKit
//
//class FitnessProfileViewController: UIViewController {
//
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "FITNESS PROFILE"
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
//
//    private let backButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//        button.tintColor = .white
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private let fields: [(label: String, placeholder: String)] = [
//        ("Gender", "Male"),
//        ("Height", "180 cm"),
//        ("Weight", "85 kg"),
//        ("Weight goal", "75 kg"),
//        ("Fitness level", "Beginner"),
//        ("Goal", "Build strength"),
//        ("Max squats", "10-30"),
//        ("Max pullups", "10-30"),
//        ("Max pushups", "10-30"),
//        ("Max dips", "10-30")
//    ]
//
//    private var fieldLabels = [UILabel]()
//    private var textFields = [UITextField]()
//
//    private let saveButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Save Changes", for: .normal)
//        button.backgroundColor = UIColor.systemBlue
//        button.layer.cornerRadius = 20
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        setupLayout()
//    }
//
//    private func setupLayout() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//        contentView.addSubview(titleLabel)
//
//        for field in fields {
//            let label = createLabel(text: field.label)
//            let textField = createInputField(placeholder: field.placeholder)
//            fieldLabels.append(label)
//            textFields.append(textField)
//            contentView.addSubview(label)
//            contentView.addSubview(textField)
//        }
//
//        contentView.addSubview(saveButton)
//
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalToSuperview()
//        }
//
//        titleLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(backButton)
//            make.centerX.equalToSuperview()
//        }
//
//        var previousView: UIView = titleLabel
//
//        for (index, label) in fieldLabels.enumerated() {
//            label.snp.makeConstraints { make in
//                make.top.equalTo(previousView.snp.bottom).offset(20)
//                make.left.equalToSuperview().offset(20)
//            }
//
//            let textField = textFields[index]
//            textField.snp.makeConstraints { make in
//                make.top.equalTo(label.snp.bottom).offset(5)
//                make.left.right.equalToSuperview().inset(20)
//                make.height.equalTo(50)
//            }
//            previousView = textField
//        }
//
//        saveButton.snp.makeConstraints { make in
//            make.top.equalTo(previousView.snp.bottom).offset(30)
//            make.left.right.equalToSuperview().inset(20)
//            make.height.equalTo(50)
//            make.bottom.equalToSuperview().offset(-40)
//        }
//    }
//
//    @objc private func backButtonTapped() {
//        dismiss(animated: true, completion: nil)
//    }
//
//    @objc private func saveButtonTapped() {
//        print("Changes Saved")
//    }
//
//    private func createInputField(placeholder: String) -> UITextField {
//        let textField = UITextField()
//        textField.text = placeholder
//        textField.textColor = .white
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.backgroundColor = .black
//        textField.layer.borderColor = UIColor.white.cgColor
//        textField.layer.borderWidth = 1
//        textField.layer.cornerRadius = 8
//        textField.textAlignment = .center
//        return textField
//    }
//
//    private func createLabel(text: String) -> UILabel {
//        let label = UILabel()
//        label.text = text
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 14)
//        return label
//    }
//}
