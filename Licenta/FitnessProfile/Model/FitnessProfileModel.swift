struct FitnessField {
    let label: String
    let placeholder: String
    var value: String
}

struct FitnessProfileModel {
    var fields: [FitnessField]
    
    init() {
        fields = [
            FitnessField(label: "Gender", placeholder: "Male", value: ""),
            FitnessField(label: "Height", placeholder: "180 cm", value: ""),
            FitnessField(label: "Weight", placeholder: "85 kg", value: ""),
            FitnessField(label: "Weight goal", placeholder: "75 kg", value: ""),
            FitnessField(label: "Fitness level", placeholder: "Beginner", value: ""),
            FitnessField(label: "Goal", placeholder: "Build strength", value: ""),
            FitnessField(label: "Max squats", placeholder: "10-30", value: ""),
            FitnessField(label: "Max pullups", placeholder: "10-30", value: ""),
            FitnessField(label: "Max pushups", placeholder: "10-30", value: ""),
            FitnessField(label: "Max dips", placeholder: "10-30", value: "")
        ]
    }
}
