import Foundation

struct ExerciseModel {
    let title: String
    var selectedIndex: Int?
}

struct AccountDetailsModel {
    var username: String?
    var name: String?
    var password: String?
    var email: String?
}

struct CreateAccountModel {
    var maxSquats: String?
    var maxDips: String?
    var maxPushups: String?
    var maxPullups: String?
    var weight: Int?
    var isMan: Bool?
    var height: Int?
    var fitnessLevel: String?
    var goals: String?
    var accountDetailsModel: AccountDetailsModel?
}
