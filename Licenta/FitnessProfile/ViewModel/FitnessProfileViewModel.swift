

class FitnessProfileViewModel {
    private(set) var model: FitnessProfileModel
    var didUpdateModel: (() -> Void)?
    var showAlert: ((String, String) -> Void)?
    
    init() {
        self.model = FitnessProfileModel()
    }
    
    func updateField(at index: Int, with value: String) {
        model.fields[index].value = value
    }
    
    func saveChanges() {
        if validateFields() {
            // Aici poți adăuga logica de salvare (API call etc.)
            print("Saved data:", model.fields.map { $0.value })
            showAlert?("Success", "Profile updated successfully")
        } else {
            showAlert?("Error", "Please fill all required fields")
        }
    }
    
    private func validateFields() -> Bool {
        return !model.fields.contains { $0.value.isEmpty }
    }
}
