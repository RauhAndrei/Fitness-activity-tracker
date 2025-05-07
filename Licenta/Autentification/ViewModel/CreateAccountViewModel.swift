import Foundation

class CreateAccountViewModel {
    
    // MARK: - State
    var currentIndex: Int = 0 {
        didSet {
            onIndexChanged?(currentIndex)
        }
    }
    
    var exercises: [ExerciseModel] = [
        ExerciseModel(title: "Max Squats", selectedIndex: nil),
        ExerciseModel(title: "Max Pushups", selectedIndex: nil),
        ExerciseModel(title: "Max Dips", selectedIndex: nil),
        ExerciseModel(title: "Max Pullups", selectedIndex: nil)
    ]
    
    // MARK: - Callback
    var onIndexChanged: ((Int) -> Void)?
    
    // MARK: - Views (bound from VC)
    weak var genderView: GenderSelectionView?
    weak var heightView: HeightSelectionView?
    weak var fitnessLevelView: FitnessLevelView?
    weak var goalsView: GoalsView?
    weak var accountDetailsView: AccountDetailsView?
    var viewController: CreateAccountViewController?
    
    // MARK: - Data
    var username: String = ""
    var name: String = ""
    var email: String = ""
    
    var selectedGender: String?
    var selectedHeight: Int?
    var selectedFitnessLevel: Int?
    var selectedGoalIndex: Int?

    var isOnLastPage: Bool {
        return currentIndex == allPagesCount - 1
    }

    var allPagesCount: Int {
        return exercises.count + 7
    }

    // MARK: - Logic
    func nextTapped() {
        // Verifică dacă suntem pe ultima pagină
        if currentIndex == allPagesCount - 2 {
            // Validarea câmpurilor doar pe ultima pagină
            if let accountDetailsView = accountDetailsView,
               let viewController = viewController,
               !accountDetailsView.validateAndShowAlertIfNeeded(on: viewController) {
                return // Oprește dacă sunt câmpuri necompletate pe ultima pagină
            }
        }
        
        // Dacă nu suntem pe ultima pagină, putem naviga fără validare
        if currentIndex < allPagesCount - 1 {
            currentIndex += 1
        }
    }
    
    func updateSelectedIndex(for index: Int, at exerciseIndex: Int) {
        guard exercises.indices.contains(exerciseIndex) else { return }
        exercises[exerciseIndex].selectedIndex = index
    }

    func validateAccountDetails() -> Bool {
        guard let view = accountDetailsView else { return false }
        return view.isValid()
    }

    func saveFinalAccountDetails() {
        if let accountDetails = accountDetailsView?.getAccountDetails() {
            username = accountDetails.username ?? ""
            name = accountDetails.name ?? ""
            email = accountDetails.email ?? ""
        }
    }

    func getAccountInfo() -> String {
        return """
        Account created with:
        Username: \(username)
        Name: \(name)
        Email: \(email)
        Gender: \(selectedGender ?? "N/A")
        Height: \(selectedHeight != nil ? "\(selectedHeight!)cm" : "N/A")
        Fitness Level: \(selectedFitnessLevel != nil ? "\(selectedFitnessLevel!)" : "N/A")
        Goal: \(selectedGoalIndex != nil ? "\(selectedGoalIndex!)" : "N/A")
        Exercises: \(exercises.map { "\($0.title): \($0.selectedIndex ?? -1)" }.joined(separator: ", "))
        """
    }
}
