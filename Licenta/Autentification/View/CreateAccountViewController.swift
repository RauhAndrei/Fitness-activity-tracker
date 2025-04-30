import UIKit

class CreateAccountViewController: UIViewController {
    
    private let viewModel = CreateAccountViewModel()
    
    private var exerciseViews: [ExercisesMax] = []
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
        viewModel.onIndexChanged = { [weak self] index, isLast in
            guard let self = self else { return }
            let offset = CGPoint(x: CGFloat(index) * self.scrollView.frame.width, y: 0)
            self.scrollView.setContentOffset(offset, animated: true)
            self.nextButton.setTitle(isLast ? "Finish" : "Next >", for: .normal)
        }
    }
    
    @objc private func nextButtonTapped() {
        viewModel.nextTapped()
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
        
        for (index, model) in viewModel.exercises.enumerated() {
            let exerciseView = ExercisesMax(title: model.title)
            exerciseView.selectionHandler = { [weak self] selectedIndex in
                self?.viewModel.updateSelectedIndex(for: selectedIndex, at: index)
            }
            exerciseViews.append(exerciseView)
            contentView.addSubview(exerciseView)
        }
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView).multipliedBy(exerciseViews.count)
        }
        
        for (index, view) in exerciseViews.enumerated() {
            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(scrollView)
                if index == 0 {
                    make.leading.equalTo(contentView)
                } else {
                    make.leading.equalTo(exerciseViews[index - 1].snp.trailing)
                }
                if index == exerciseViews.count - 1 {
                    make.trailing.equalTo(contentView)
                }
            }
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(120)
            make.height.equalTo(56)
        }
    }
}

extension CreateAccountViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        viewModel.currentIndex = index
        let isLast = viewModel.isLastExercise
        nextButton.setTitle(isLast ? "Finish" : "Next >", for: .normal)
    }
}
