class NotificationViewModel {
    private(set) var sections: [NotificationSection] = []
    
    init() {
        setupNotifications()
    }
    
    private func setupNotifications() {
        let items = [
            NotificationItem(title: "Send workout notification", isEnabled: true),
            NotificationItem(title: "Send ad notification", isEnabled: true),
            NotificationItem(title: "Enable sounds", isEnabled: true)
        ]
        sections = [.main(items: items)]
    }
    
    func toggleNotification(at index: Int) {
        if case .main(var items) = sections.first {
            items[index].isEnabled.toggle()
            sections = [.main(items: items)]
        }
    }
}
