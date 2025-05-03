import Foundation

class CreateAccountViewModel {
    struct ExerciseModel {
        let title: String
        var selectedIndex: Int?
    }

    // MARK: - Date cont
    var username: String = ""
    var name: String = ""
    var email: String = ""

    // MARK: - Date exerciții
    var exercises: [ExerciseModel] = [
        ExerciseModel(title: "Max Squats", selectedIndex: nil),
        ExerciseModel(title: "Max Pushups", selectedIndex: nil),
        ExerciseModel(title: "Max Dips", selectedIndex: nil),
        ExerciseModel(title: "Max Pullups", selectedIndex: nil)
    ]

    var currentIndex: Int = 0 {
        didSet {
            onIndexChanged?(currentIndex)
        }
    }

    var selectedGender: String?
    var selectedHeight: Int?
    var selectedFitnessLevel: Int?
    var selectedGoalIndex: Int?

    var onIndexChanged: ((Int) -> Void)?

    func nextTapped() {
        guard currentIndex < allPagesCount - 1 else { return }
        currentIndex += 1
    }

    func previousTapped() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }

    func updateSelectedIndex(for index: Int, at exerciseIndex: Int) {
        guard exerciseIndex < exercises.count else { return }
        exercises[exerciseIndex].selectedIndex = index
    }

    func validateCurrentPage(index: Int) -> Bool {
        switch index {
        case 0..<exercises.count:
            return exercises[index].selectedIndex != nil
        case exercises.count:
            return selectedGender != nil
        case exercises.count + 1:
            return selectedHeight != nil
        case exercises.count + 2:
            return selectedFitnessLevel != nil
        case exercises.count + 3:
            return selectedGoalIndex != nil
        default:
            return false
        }
    }

    var allPagesCount: Int {
        return exercises.count + 4
    }

    func getAccountDetails() -> (username: String, name: String, email: String) {
        return (username, name, email)
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
