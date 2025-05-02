class CreateAccountViewModel {
    var exercises: [ExerciseModel] = [
        ExerciseModel(title: "Max Squats", selectedIndex: nil),
        ExerciseModel(title: "Max Pushups", selectedIndex: nil),
        ExerciseModel(title: "Max Dips", selectedIndex: nil),
        ExerciseModel(title: "Max Pullups", selectedIndex: nil)
    ]
    
    var currentIndex: Int = 3 {
        didSet {
            onIndexChanged?(currentIndex)
        }
    }
    
    var onIndexChanged: ((Int) -> Void)?
    
    func nextTapped() {
        guard currentIndex < exercises.count + 1 else { return }
        currentIndex += 1
    }
    
    func updateSelectedIndex(for index: Int, at exerciseIndex: Int) {
        guard exerciseIndex < exercises.count else { return }
        exercises[exerciseIndex].selectedIndex = index
    }
}
