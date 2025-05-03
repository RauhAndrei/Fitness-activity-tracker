import UIKit
import SnapKit

class CreateAccountViewController: UIViewController {
    
    private let viewModel = CreateAccountViewModel()
    private var allPages: [UIView] = []
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CREATE ACCOUNT"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next >", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onIndexChanged = { [weak self] index in
            guard let self = self else { return }
            let offset = CGPoint(x: CGFloat(index) * self.scrollView.frame.width, y: 0)
            self.scrollView.setContentOffset(offset, animated: true)
            self.updateButtonTitle(for: index)
        }
    }
    
    @objc private func nextButtonTapped() {
        if viewModel.isOnLastPage {
            guard viewModel.validateAccountDetails() else {
                showAlert(title: "Complete All Fields", message: "Please complete all account details before finishing.")
                return
            }
            viewModel.saveFinalAccountDetails()
            print(viewModel.getAccountInfo())
            navigationController?.popToRootViewController(animated: true)
        } else {
            viewModel.nextTapped()
        }
    }
    
    private func updateButtonTitle(for index: Int) {
        let isLast = index == allPages.count - 1
        nextButton.setTitle(isLast ? "Finish" : "Next >", for: .normal)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        
        // Initialize and add exercise views
        for (index, model) in viewModel.exercises.enumerated() {
            let exerciseView = ExercisesMax(title: model.title)
            exerciseView.selectionHandler = { [weak self] selectedIndex in
                self?.viewModel.updateSelectedIndex(for: selectedIndex, at: index)
            }
            allPages.append(exerciseView)
            contentView.addSubview(exerciseView)
        }
        
        let genderView = GenderSelectionView()
        viewModel.genderView = genderView
        allPages.append(genderView)
        contentView.addSubview(genderView)
        
        let heightView = HeightSelectionView()
        viewModel.heightView = heightView
        allPages.append(heightView)
        contentView.addSubview(heightView)
        
        let fitnessView = FitnessLevelView()
        viewModel.fitnessLevelView = fitnessView
        allPages.append(fitnessView)
        contentView.addSubview(fitnessView)
        
        let goalsView = GoalsView()
        viewModel.goalsView = goalsView
        allPages.append(goalsView)
        contentView.addSubview(goalsView)
        
        let accountDetailsView = AccountDetailsView()
        viewModel.accountDetailsView = accountDetailsView
        allPages.append(accountDetailsView)
        contentView.addSubview(accountDetailsView)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(120)
            make.height.equalTo(56)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView).multipliedBy(allPages.count)
        }
        
        for (index, page) in allPages.enumerated() {
            page.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(scrollView)
                if index == 0 {
                    make.leading.equalTo(contentView)
                } else {
                    make.leading.equalTo(allPages[index - 1].snp.trailing)
                }
                if index == allPages.count - 1 {
                    make.trailing.equalTo(contentView)
                }
            }
        }
    }
}

extension CreateAccountViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        viewModel.currentIndex = index
    }
}
