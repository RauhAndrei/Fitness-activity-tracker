import UIKit
import SnapKit

class PushUpViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "BEGINNER"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let weekLabel: UILabel = {
        let label = UILabel()
        label.text = "Week 1"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let workoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 2 - Push Up"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "push_up")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let equipmentView: WorkoutInfoView = {
        let view = WorkoutInfoView()
        view.configure(title: "Required Equipment:", value: "Box, Bench", subtitle: nil)
        return view
    }()
    
    private let workoutRoundsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Workout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
        setupWorkoutRounds()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        title = "Training Program"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(progressLabel)
        contentView.addSubview(weekLabel)
        contentView.addSubview(workoutLabel)
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(equipmentView)
        contentView.addSubview(workoutRoundsView)
        contentView.addSubview(startButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12) // Redus
            make.centerX.equalToSuperview()
        }
        
        weekLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(0) // Eliminat spațiu
            make.leading.equalToSuperview().offset(20)
        }
        
        workoutLabel.snp.makeConstraints { make in
            make.top.equalTo(weekLabel.snp.bottom).offset(0) // Eliminat spațiu
            make.leading.equalToSuperview().offset(20)
        }
        
        exerciseImageView.snp.makeConstraints { make in
            make.top.equalTo(workoutLabel.snp.bottom).offset(0) // Eliminat spațiu
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }

        equipmentView.snp.makeConstraints { make in
            make.top.equalTo(exerciseImageView.snp.bottom).offset(0) // Eliminat spațiu
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        workoutRoundsView.snp.makeConstraints { make in
            make.top.equalTo(equipmentView.snp.bottom).offset(0) // Eliminat spațiu
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(workoutRoundsView.snp.bottom).offset(12) // Păstrat mic spațiu pentru buton
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView).offset(-12) // Redus
        }
    }
    
    private func setupWorkoutRounds() {
        let round1Header = createRoundHeader(text: "Round 1    3 Sets")
        workoutRoundsView.addSubview(round1Header)
        
        // Round 1 Exercises
        let exercise1 = createExerciseView(
            name: "Push Up Pumps",
            details: "10 Reps • Rest 45 seconds",
            imageName: "push_up_pumps"
        )
        
        let exercise2 = createExerciseView(
            name: "Incline Push Ups",
            details: "5 Reps each • Rest 60 seconds",
            imageName: "incline_push_ups"
        )
        
        // Round 2 Exercises
        let exercise3 = createExerciseView(
            name: "High Plank Hold",
            details: "30 Seconds • Rest 45 seconds",
            imageName: "high_plank_hold"
        )
        
        let exercise4 = createExerciseView(
            name: "Plank Side Hold",
            details: "15 Seconds each side • Rest 60 seconds",
            imageName: "plank_side_hold"
        )
        
        // Add views to workoutRoundsView, EXCLUDING rest1
        let views = [round1Header, exercise1, exercise2, exercise3, exercise4]
        var previousView: UIView?
        
        for view in views {
            workoutRoundsView.addSubview(view)
            
            view.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                
                if let previous = previousView {
                    make.top.equalTo(previous.snp.bottom).offset(12)
                } else {
                    make.top.equalToSuperview()
                }
            }
            
            previousView = view
        }
        
        previousView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }

    private func createRoundHeader(text: String) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }
    
    private func createExerciseView(name: String, details: String, imageName: String) -> UIView {
        let view = UIView()
        
        // Image View
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        
        // Exercise Name Label
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        
        // Exercise Details Label
        let detailsLabel = UILabel()
        detailsLabel.text = details
        detailsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        detailsLabel.textColor = .lightGray
        detailsLabel.numberOfLines = 0
        
        // Text Stack View
        let textStackView = UIStackView(arrangedSubviews: [nameLabel, detailsLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 6
        
        // Main Horizontal Stack
        let mainStackView = UIStackView(arrangedSubviews: [imageView, textStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.alignment = .center
        
        view.addSubview(mainStackView)
        
        // Constraints
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        return view
    }
    
    private func createRestView(text: String) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemBlue
        label.textAlignment = .center
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        return view
    }
}
