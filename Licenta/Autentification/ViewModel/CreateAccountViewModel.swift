class CreateAccountViewModel {
    struct ExerciseModel {
        let title: String
        var selectedIndex: Int?
    }
    
    var exercises: [ExerciseModel] = [
        ExerciseModel(title: "Max Squats", selectedIndex: nil),
        ExerciseModel(title: "Max Pushups", selectedIndex: nil),
        ExerciseModel(title: "Max Dips", selectedIndex: nil),
        ExerciseModel(title: "Max Pullups", selectedIndex: nil)
    ]
    
    var currentIndex: Int = 4 {
        didSet {
            onIndexChanged?(currentIndex)
        }
    }
    
    var selectedGender: String?
    var selectedHeight: Int?
    var selectedFitnessLevel: Int?
    
    var onIndexChanged: ((Int) -> Void)?
    
    func nextTapped() {
        guard currentIndex < allPagesCount - 1 else { return }
        currentIndex += 1
    }
    
    func updateSelectedIndex(for index: Int, at exerciseIndex: Int) {
        guard exerciseIndex < exercises.count else { return }
        exercises[exerciseIndex].selectedIndex = index
    }
    
    var allPagesCount: Int {
        return exercises.count + 3 // exercises + gender + height + fitness level
    }
}
