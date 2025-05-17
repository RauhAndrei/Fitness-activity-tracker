import UIKit
import SnapKit

class PullUpChinUpViewController: UIViewController {
    
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
        label.text = "Day 1 - Pull Up & Chin Up"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "australian_pull_up")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let equipmentView: WorkoutInfoView = {
        let view = WorkoutInfoView()
        view.configure(title: "Required Equipment:", value: "Dip Bar", subtitle: nil)
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
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        weekLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        
        workoutLabel.snp.makeConstraints { make in
            make.top.equalTo(weekLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        exerciseImageView.snp.makeConstraints { make in
            make.top.equalTo(workoutLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        equipmentView.snp.makeConstraints { make in
            make.top.equalTo(exerciseImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        workoutRoundsView.snp.makeConstraints { make in
            make.top.equalTo(equipmentView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(workoutRoundsView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
    
    private func setupWorkoutRounds() {
        // Round 1 Header
        let round1Header = createRoundHeader(text: "Round 1    3 Sets")
        workoutRoundsView.addSubview(round1Header)
        
        // Round 1 Exercises
        let exercise1 = createExerciseView(
            name: "Australian Pull Ups",
            details: "10 Reps • Rest 45 seconds",
            imageName: "australian_pull_ups"
        )
        
        let exercise2 = createExerciseView(
            name: "Australian Pull Up (Wide + Shoulder + Close Grip)",
            details: "5 Reps each • Rest 60 seconds",
            imageName: "australian_pull_ups_wide"
        )
        
        let rest1 = createRestView(text: "Rest    2 minutes")
        
        // Round 2 Header
        let round2Header = createRoundHeader(text: "Round 2    3 Sets")
        
        // Round 2 Exercises
        let exercise3 = createExerciseView(
            name: "Australian Chin Ups",
            details: "10 Reps • Rest 45 seconds",
            imageName: "australian_chin_ups"
        )
        
        let exercise4 = createExerciseView(
            name: "Australian Chin Up (Wide + Shoulder + Close Grip)",
            details: "5 Reps each • Rest 60 seconds",
            imageName: "australian_chin_ups_wide"
        )
        
        // Add all views to workoutRoundsView
        let views = [round1Header, exercise1, exercise2, rest1, round2Header, exercise3, exercise4]
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
        
        // Make sure the last view is connected to the bottom
        previousView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
    
    private func createExerciseView(name: String, details: String, imageName: String) -> UIView {
        let view = UIView()
        
        // Image View - increased size from 40 to 60
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 8 // increased from 6
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1 // increased from 0.5
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        
        // Exercise Name Label - increased font size
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium) // was 16
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        
        // Exercise Details Label - increased font size
        let detailsLabel = UILabel()
        detailsLabel.text = details
        detailsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular) // was 14
        detailsLabel.textColor = .lightGray
        detailsLabel.numberOfLines = 0
        
        // Text Stack View
        let textStackView = UIStackView(arrangedSubviews: [nameLabel, detailsLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 6 // increased from 4
        
        // Main Horizontal Stack
        let mainStackView = UIStackView(arrangedSubviews: [imageView, textStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16 // increased from 12
        mainStackView.alignment = .center
        
        view.addSubview(mainStackView)
        
        // Constraints - increased image size
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(60) // was 40
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12) // increased from 8
        }
        
        return view
    }

    // In the createRoundHeader method - update font size
    private func createRoundHeader(text: String) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // was 18
        label.textColor = .white
        label.textAlignment = .left
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }

    // In the createRestView method - update font size
    private func createRestView(text: String) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium) // was 16
        label.textColor = .systemBlue
        label.textAlignment = .center
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10) // increased from 8
        }
        
        return view
    }
}
