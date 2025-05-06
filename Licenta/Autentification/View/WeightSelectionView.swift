import UIKit
import SnapKit

class WeightSelectionView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Weight"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "kg"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let values = Array(30...200).map { $0 } // Greutăți de la 30 kg la 200 kg
    var selectedWeight: Int = 70
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .black
        
        addSubview(titleLabel)
        addSubview(pickerView)
        addSubview(unitLabel)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Select default value (70 kg)
        if let defaultIndex = values.firstIndex(of: 70) {
            pickerView.selectRow(defaultIndex, inComponent: 0, animated: false)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(-15)
            make.width.equalTo(170)
            make.height.equalTo(370)
        }
        
        unitLabel.snp.makeConstraints { make in
            make.leading.equalTo(pickerView.snp.trailing).offset(5)
            make.centerY.equalTo(pickerView)
        }
    }
    
    func getSelectedWeight() -> Int {
        return selectedWeight
    }
}

extension WeightSelectionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .clear // Fără fundal special
        label.text = "\(values[row])"
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWeight = values[row]
    }
}
