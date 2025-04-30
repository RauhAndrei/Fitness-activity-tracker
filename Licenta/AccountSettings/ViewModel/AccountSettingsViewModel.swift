class AccountSettingsViewModel {
    private(set) var model: AccountSettingsModel
    var didUpdateModel: (() -> Void)?
    var showAlert: ((String, String) -> Void)?
    
    init() {
        self.model = AccountSettingsModel()
    }
    
    func updateField(at index: Int, with value: String) {
        model.fields[index].value = value
        didUpdateModel?()
    }
    
    func saveChanges() {
        let isValid = !model.fields.contains { $0.value.isEmpty }
        
        if isValid {
            print("Saved data:", model.fields.map { $0.value })
            // Aici poți adăuga logica de salvare reală (API call etc.)
        } else {
            showAlert?("Error", "Please fill all fields")
        }
    }
}
