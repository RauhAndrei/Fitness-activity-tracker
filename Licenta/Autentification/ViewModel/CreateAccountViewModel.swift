import Foundation

class CreateAccountViewModel {
    private(set) var exercises: [ExerciseModel]
    var currentIndex = 0
    
    var onIndexChanged: ((Int, Bool) -> Void)?
    
    init() {
        exercises = [
            ExerciseModel(title: "Max Squats"),
            ExerciseModel(title: "Max Dips"),
            ExerciseModel(title: "Max Pushups"),
            ExerciseModel(title: "Max Pullups")
        ]
    }
    
    var currentExerciseTitle: String {
        exercises[currentIndex].title
    }
    
    var isLastExercise: Bool {
        currentIndex == exercises.count - 1
    }
    
    func nextTapped() {
        if currentIndex < exercises.count - 1 {
            currentIndex += 1
            onIndexChanged?(currentIndex, isLastExercise)
        } else {
            print("Finished exercises sequence")
            // Handle finish action (e.g., create account)
        }
    }
    
    func updateSelectedIndex(for index: Int, at pageIndex: Int) {
        exercises[pageIndex].selectedIndex = index
    }
    
    func selectedIndex(for pageIndex: Int) -> Int? {
        exercises[pageIndex].selectedIndex
    }
}
