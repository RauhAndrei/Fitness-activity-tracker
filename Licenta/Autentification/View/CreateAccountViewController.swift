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
    
    private var genderView: GenderSelectionView?
    private var heightView: HeightSelectionView?
    private var fitnessLevelView: FitnessLevelView?
    private var goalsView: GoalsView?
    private var accountDetailsView: AccountDetailsView?
    
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
            
            let isOnLastPage = index == self.allPages.count - 1
            self.nextButton.setTitle(isOnLastPage ? "Finish" : "Next >", for: .normal)
        }
    }
    
    @objc private func nextButtonTapped() {
        let isOnLastPage = viewModel.currentIndex == allPages.count - 1
        
        if isOnLastPage {
            guard let accountDetailsView = accountDetailsView,
                  accountDetailsView.isValid() else {
                showAlert(title: "Complete All Fields",
                         message: "Please complete all account details before finishing.")
                return
            }
            
            saveAllDataToViewModel()
            printAccountDetails()
            navigationController?.popToRootViewController(animated: true)
        } else {
            let nextIndex = viewModel.currentIndex + 1
            viewModel.currentIndex = nextIndex
            
            let offset = CGPoint(x: CGFloat(nextIndex) * scrollView.frame.width, y: 0)
            scrollView.setContentOffset(offset, animated: true)
            
            let isOnLastPage = nextIndex == allPages.count - 1
            nextButton.setTitle(isOnLastPage ? "Finish" : "Next >", for: .normal)
        }
    }
    
    private func saveAllDataToViewModel() {
        if let accountDetails = accountDetailsView?.getAccountDetails() {
            viewModel.username = accountDetails.username
            viewModel.name = accountDetails.name
            viewModel.email = accountDetails.email
        }
        
        viewModel.selectedGender = genderView?.getSelectedGender()
        viewModel.selectedHeight = heightView?.getSelectedHeight()
        viewModel.selectedFitnessLevel = fitnessLevelView?.getSelectedIndex()
        viewModel.selectedGoalIndex = goalsView?.getSelectedIndex()
        
        for (index, page) in allPages.enumerated() {
            if let exerciseView = page as? ExercisesMax {
                if let selectedIndex = exerciseView.selectedIndex {
                    viewModel.updateSelectedIndex(for: selectedIndex, at: index)
                }
            }
        }
    }
    
    private func printAccountDetails() {
        print("Account created with settings:")
        print("Username: \(viewModel.username)")
        print("Name: \(viewModel.name)")
        print("Email: \(viewModel.email)")
        print("Gender: \(viewModel.selectedGender ?? "Not selected")")
        print("Height: \(viewModel.selectedHeight ?? 0)cm")
        print("Fitness Level: \(viewModel.selectedFitnessLevel ?? -1)")
        print("Goal: \(viewModel.selectedGoalIndex ?? -1)")
        print("Exercises: \(viewModel.exercises)")
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
        
        // Add exercises
        for (index, model) in viewModel.exercises.enumerated() {
            let exerciseView = ExercisesMax(title: model.title)
            exerciseView.selectionHandler = { [weak self] selectedIndex in
                self?.viewModel.updateSelectedIndex(for: selectedIndex, at: index)
            }
            allPages.append(exerciseView)
            contentView.addSubview(exerciseView)
        }
        
        // Add GenderSelectionView
        let genderSelection = GenderSelectionView()
        genderView = genderSelection
        allPages.append(genderSelection)
        contentView.addSubview(genderSelection)
        
        // Add HeightSelectionView
        let heightSelection = HeightSelectionView()
        heightView = heightSelection
        allPages.append(heightSelection)
        contentView.addSubview(heightSelection)
        
        // Add FitnessLevelView
        let fitnessView = FitnessLevelView()
        fitnessLevelView = fitnessView
        allPages.append(fitnessView)
        contentView.addSubview(fitnessView)
        
        // Add GoalsView
        let goalsSelection = GoalsView()
        goalsView = goalsSelection
        allPages.append(goalsSelection)
        contentView.addSubview(goalsSelection)
        
        // Add AccountDetailsView (last page)
        let accountView = AccountDetailsView()
        accountDetailsView = accountView
        allPages.append(accountView)
        contentView.addSubview(accountView)
        
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
        let isOnLastPage = index == allPages.count - 1
        nextButton.setTitle(isOnLastPage ? "Finish" : "Next >", for: .normal)
    }
}
