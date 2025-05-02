import Foundation

class CreateAccountViewModel {
    
    // Exercițiile care apar în onboarding
    var exercises: [ExerciseModel] = [
        ExerciseModel(title: "Max Squats", selectedIndex: nil),
        ExerciseModel(title: "Max Pushups", selectedIndex: nil),
        ExerciseModel(title: "Max Dips", selectedIndex: nil),
        ExerciseModel(title: "Max Pullups", selectedIndex: nil)
    ]
    
    // Indexul curent (poziția în scrollView)
    var currentIndex: Int = 0 {
        didSet {
            onIndexChanged?(currentIndex, isLastExercise)
        }
    }
    
    // Callback pentru update-ul scroll-ului și al butonului
    var onIndexChanged: ((Int, Bool) -> Void)?
    
    // Verifică dacă este ultimul exercițiu (nu și gender view)
    var isLastExercise: Bool {
        return currentIndex == exercises.count - 1
    }

    // Avansează la pasul următor
    func nextTapped() {
        guard currentIndex < exercises.count else { return }
        currentIndex += 1
    }
    
    // Actualizează selecția făcută pe un exercițiu
    func updateSelectedIndex(for index: Int, at exerciseIndex: Int) {
        guard exerciseIndex < exercises.count else { return }
        exercises[exerciseIndex].selectedIndex = index
    }
}
