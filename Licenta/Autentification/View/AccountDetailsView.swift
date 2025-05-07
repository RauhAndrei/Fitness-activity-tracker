import UIKit
import SnapKit

class AccountDetailsView: UIView, UITextFieldDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Details"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.autocapitalizationType = .none
        tf.textColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.clipsToBounds = true
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.leftViewMode = .always
        tf.textContentType = .none
        tf.placeholder = "Enter your username"  // Placeholder text
        tf.attributedPlaceholder = NSAttributedString(string: "Enter your username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.clipsToBounds = true
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.leftViewMode = .always
        tf.textContentType = .none
        tf.placeholder = "Enter your full name"  // Placeholder text
        tf.attributedPlaceholder = NSAttributedString(string: "Enter your full name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }()
    
    private let passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .white
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.clipsToBounds = true
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.leftViewMode = .always
        tf.textContentType = .none
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.placeholder = "Enter a strong password"  // Placeholder text
        tf.attributedPlaceholder = NSAttributedString(string: "Enter a strong password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.textColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.clipsToBounds = true
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.leftViewMode = .always
        tf.textContentType = .none
        tf.placeholder = "Enter your email address"  // Placeholder text
        tf.attributedPlaceholder = NSAttributedString(string: "Enter your email address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupDelegates()
        setupTapGesture()
        configureKeyboardHandling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .black
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(usernameTitleLabel)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(nameTitleLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(passwordTitleLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(emailTitleLabel)
        contentView.addSubview(emailTextField)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.top.bottom.equalTo(scrollView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        usernameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)  // Schimbat de la 30 la 16
            make.leading.trailing.equalToSuperview().inset(16)
        }

        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }

        nameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(16)  // Schimbat de la 30 la 16
            make.leading.trailing.equalToSuperview().inset(16)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }

        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)  // Schimbat de la 30 la 16
            make.leading.trailing.equalToSuperview().inset(16)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }

        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)  // Schimbat de la 30 la 16
            make.leading.trailing.equalToSuperview().inset(16)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupDelegates() {
        usernameTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            emailTextField.resignFirstResponder() // Ascunde tastatura
        }
        return true
    }
    
    func isValid() -> Bool {
        return !(usernameTextField.text?.isEmpty ?? true) &&
               !(nameTextField.text?.isEmpty ?? true) &&
               !(emailTextField.text?.isEmpty ?? true)
    }
    
    func getAccountDetails() -> (username: String, name: String, email: String) {
        return (usernameTextField.text ?? "", nameTextField.text ?? "", emailTextField.text ?? "")
    }
    
    private func configureKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // Creează un inset pentru scroll view când tastatura apare
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset

            // Muta scroll-ul astfel încât câmpul activ să fie vizibil
            if let activeField = findFirstResponder() {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        // Resetează contentInset și scrollIndicatorInsets atunci când tastatura dispare
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    // Funcție care returnează câmpul activ
    private func findFirstResponder() -> UIView? {
        if usernameTextField.isFirstResponder {
            return usernameTextField
        } else if nameTextField.isFirstResponder {
            return nameTextField
        } else if passwordTextField.isFirstResponder {
            return passwordTextField
        } else if emailTextField.isFirstResponder {
            return emailTextField
        }
        return nil
    }
    
    // Funcție pentru validarea unui email simplu
    func isValidEmail(_ email: String) -> Bool {
        // Expresie regulată simplă pentru a verifica dacă email-ul conține "@" și "."
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validateAndShowAlertIfNeeded(on viewController: UIViewController) -> Bool {
        if usernameTextField.text?.isEmpty ?? true {
            showAlert(on: viewController, title: "Missing Username", message: "Please enter a username.")
            return false
        }
        if nameTextField.text?.isEmpty ?? true {
            showAlert(on: viewController, title: "Missing Name", message: "Please enter your full name.")
            return false
        }
        if passwordTextField.text?.isEmpty ?? true {
            showAlert(on: viewController, title: "Missing Password", message: "Please enter a password.")
            return false
        }
        if emailTextField.text?.isEmpty ?? true {
            showAlert(on: viewController, title: "Missing Email", message: "Please enter your email address.")
            return false
        }
        
        if let email = emailTextField.text, !isValidEmail(email) {
            showAlert(on: viewController, title: "Invalid Email", message: "Please enter a valid email address.")
            return false
        }
        
        return true
    }

    // General alert display function with title
    func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

}
