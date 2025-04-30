import Foundation

class CreateAccountViewModel {
    private(set) var exercises: [ExerciseModel]
    var currentIndex = 0
    
    // Modelul care va stoca toate datele
    private var model = CreateAccountModel()
    
    var onIndexChanged: ((Int, Bool) -> Void)?
    var onDataUpdated: (() -> Void)? // Adăugăm un callback pentru actualizări
    
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
            // Toate exercițiile sunt completate, salvează datele
//            saveData()
            print("Finished exercises sequence. Data saved.")
            print("Saved data: \(model)")
        }
    }
    
    func updateSelectedIndex(for index: Int, at pageIndex: Int) {
        exercises[pageIndex].selectedIndex = index
        
        // Actualizează modelul cu selecția curentă
        updateModelWithSelection(index: index, pageIndex: pageIndex)
        
        onDataUpdated?() // Notifică despre actualizarea datelor
    }
    
    func selectedIndex(for pageIndex: Int) -> Int? {
        exercises[pageIndex].selectedIndex
    }
    
    private func updateModelWithSelection(index: Int, pageIndex: Int) {
        let exerciseTitle = exercises[pageIndex].title
        
        // Aici poți adăuga mai multe cazuri pentru fiecare exercițiu
        switch exerciseTitle {
        case "Max Squats":
            model.maxSquats = "Option \(index + 1)" // Sau valorile tale specifice
        case "Max Dips":
            model.maxDips = "Option \(index + 1)"
        case "Max Pushups":
            model.maxPushups = "Option \(index + 1)"
        case "Max Pullups":
            model.maxPullups = "Option \(index + 1)"
        default:
            break
        }
    }
    
}





//import Foundation
//
//class CreateAccountViewModel {
//    private(set) var exercises: [ExerciseModel]
//    var currentIndex = 0
//
//    var onIndexChanged: ((Int, Bool) -> Void)?
//
//    init() {
//        exercises = [
//            ExerciseModel(title: "Max Squats"),
//            ExerciseModel(title: "Max Dips"),
//            ExerciseModel(title: "Max Pushups"),
//            ExerciseModel(title: "Max Pullups")
//        ]
//    }
//
//    var currentExerciseTitle: String {
//        exercises[currentIndex].title
//    }
//
//    var isLastExercise: Bool {
//        currentIndex == exercises.count - 1
//    }
//
//    func nextTapped() {
//        if currentIndex < exercises.count - 1 {
//            currentIndex += 1
//            onIndexChanged?(currentIndex, isLastExercise)
//        } else {
//            print("Finished exercises sequence")
//            // Handle finish action (e.g., create account)
//        }
//    }
//
//    func updateSelectedIndex(for index: Int, at pageIndex: Int) {
//        exercises[pageIndex].selectedIndex = index
//    }
//
//    func selectedIndex(for pageIndex: Int) -> Int? {
//        exercises[pageIndex].selectedIndex
//    }
//}
