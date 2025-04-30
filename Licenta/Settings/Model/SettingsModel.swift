import Foundation

struct SettingsSection {
    let title: String
    let items: [SettingsItem]
}

struct SettingsItem {
    let title: String
    let icon: String
    let action: SettingsAction
}

enum SettingsAction {
    case accountSettings
    case notifications
    case fitnessProfile
    case termsAndConditions
    case contactUs
    case logout
}
