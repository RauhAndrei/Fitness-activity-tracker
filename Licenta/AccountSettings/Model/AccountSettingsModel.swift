struct AccountField {
    let label: String
    let placeholder: String
    var value: String
}

struct AccountSettingsModel {
    var fields: [AccountField]
    
    init() {
        fields = [
            AccountField(label: "Username", placeholder: "your_username", value: ""),
            AccountField(label: "Name", placeholder: "Your Name", value: ""),
            AccountField(label: "Password", placeholder: "Change Password", value: ""),
            AccountField(label: "Email", placeholder: "your.email@example.com", value: ""),
            AccountField(label: "Phone", placeholder: "+1234567890", value: "")
        ]
    }
}
