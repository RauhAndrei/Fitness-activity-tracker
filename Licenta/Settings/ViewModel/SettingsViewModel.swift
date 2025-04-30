import Foundation

class SettingsViewModel {
    
    private(set) var sections: [SettingsSection] = []
    
    init() {
        setupSections()
    }
    
    private func setupSections() {
        sections = [
            SettingsSection(
                title: "General",
                items: [
                    SettingsItem(title: "Account settings", icon: "person.crop.circle", action: .accountSettings),
                    SettingsItem(title: "Notification", icon: "bell", action: .notifications),
                    SettingsItem(title: "Fitness profile", icon: "heart.fill", action: .fitnessProfile)
                ]
            ),
            SettingsSection(
                title: "App",
                items: [
                    SettingsItem(title: "Terms and conditions", icon: "doc.text", action: .termsAndConditions),
                    SettingsItem(title: "Contact us", icon: "envelope", action: .contactUs),
                    SettingsItem(title: "Logout", icon: "arrow.backward.square.fill", action: .logout)
                ]
            )
        ]
    }
    
    func handleAction(for action: SettingsAction) {
        switch action {
        case .accountSettings:
            print("Navigate to account settings")
        case .notifications:
            print("Navigate to notifications")
        case .logout:
            print("Perform logout")
        // Handle other cases...
        default:
            break
        }
    }
}
