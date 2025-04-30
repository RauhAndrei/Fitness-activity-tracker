struct NotificationItem {
    let title: String
    var isEnabled: Bool
}

enum NotificationSection {
    case main(items: [NotificationItem])
}
