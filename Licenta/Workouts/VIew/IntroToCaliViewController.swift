import UIKit
import SnapKit

class IntroToCaliViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "BEGINNER"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .darkGray
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let programTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Introduction To Calisthenics Program"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the Calisthenics Introduction Program! In this program we are going to learn the fundamental exercises for bodyweight training"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let introImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "introToCali")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 1
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        return iv
    }()

    private let requiredEquipmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Required Equipment:"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let equipmentListLabel: UILabel = {
        let label = UILabel()
        label.text = "dip bar, pullup bar, box, bench, pole, parallettes"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let weeksScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let weeksStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16 // Mai mare decât 10
        return stack
    }()

    private var weekButtons: [UIButton] = {
        return (1...6).map { i in
            let button = UIButton()
            button.setTitle("Week \(i)", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .darkGray
            button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium) // Font mai mic
            button.layer.cornerRadius = 6
            button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16) // Buton mai lung și mai îngust
            return button
        }
    }()


    private let workoutDaysStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private let startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start Program", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 20
        return btn
    }()

    private var selectedWeekIndex: Int? {
        didSet {
            updateWeekSelection()
            loadWorkoutDays(for: selectedWeekIndex ?? 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Training"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black

        setupUI()
        setupLayout()

        selectedWeekIndex = 0
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(badgeLabel)
        contentView.addSubview(programTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(introImageView)
        contentView.addSubview(requiredEquipmentLabel)
        contentView.addSubview(equipmentListLabel)
        contentView.addSubview(weeksScrollView)
        weeksScrollView.addSubview(weeksStackView)
        contentView.addSubview(workoutDaysStackView)
        contentView.addSubview(startButton)

        for (index, button) in weekButtons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(weekButtonTapped(_:)), for: .touchUpInside)
            weeksStackView.addArrangedSubview(button)
        }
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        badgeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(24)
            $0.width.equalTo(80)
        }

        programTitleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(programTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        introImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        requiredEquipmentLabel.snp.makeConstraints {
            $0.top.equalTo(introImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        equipmentListLabel.snp.makeConstraints {
            $0.top.equalTo(requiredEquipmentLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        weeksScrollView.snp.makeConstraints {
            $0.top.equalTo(equipmentListLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36)
        }

        weeksStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            $0.height.equalToSuperview()
        }

        workoutDaysStackView.snp.makeConstraints {
            $0.top.equalTo(weeksStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        startButton.snp.makeConstraints {
            $0.top.equalTo(workoutDaysStackView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().offset(-40)
        }
    }

    @objc private func weekButtonTapped(_ sender: UIButton) {
        selectedWeekIndex = sender.tag
    }

    private func updateWeekSelection() {
        for (index, button) in weekButtons.enumerated() {
            if index == selectedWeekIndex {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .darkGray
                button.setTitleColor(.white, for: .normal)
            }
        }
    }

    private func loadWorkoutDays(for weekIndex: Int) {
        workoutDaysStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let workoutTitles = ["Pull Up & Chin Up", "Pull Ups", "Pistol Squats", "Dips", "L-Sit Hold"]

        for i in 0..<workoutTitles.count {
            let dayView = WorkoutDayView(dayNumber: i + 1, title: workoutTitles[i])
            workoutDaysStackView.addArrangedSubview(dayView)
        }
    }
}

class WorkoutDayView: UIView {

    init(dayNumber: Int, title: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0.15, alpha: 1)
        layer.cornerRadius = 12

        let dayLabel = UILabel()
        dayLabel.text = "\(dayNumber)"
        dayLabel.textColor = .white
        dayLabel.textAlignment = .center
        dayLabel.backgroundColor = UIColor(white: 0.2, alpha: 1)
        dayLabel.layer.cornerRadius = 8
        dayLabel.clipsToBounds = true

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 14)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Workout"
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = .systemFont(ofSize: 12)

        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        let container = UIStackView(arrangedSubviews: [dayLabel, textStack])
        container.axis = .horizontal
        container.spacing = 16
        container.alignment = .center

        addSubview(container)

        dayLabel.snp.makeConstraints { $0.size.equalTo(CGSize(width: 40, height: 40)) }

        container.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
