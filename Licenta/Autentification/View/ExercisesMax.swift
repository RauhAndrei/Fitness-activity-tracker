import UIKit
import SnapKit

class ExercisesMax: UIView {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let tableView = UITableView()
    
    private let options = ["<10", "10-30", "30-50", "50+"]
    var selectedIndex: Int?
    
    // Closure pentru a trimite selecția în ViewModel
    var selectionHandler: ((Int) -> Void)?
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Forțăm table view să își actualizeze layout-ul după ce sunt setate limitele
        tableView.reloadData()
    }
    
    private func setupUI() {
        // Setează culoarea de fundal pentru view-ul principal
        backgroundColor = .black
        
        // Configurează titlul
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        
        // Configurează subtitlul
        subTitleLabel.text = "How many can you do without interruption?"
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.textColor = .white
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.backgroundColor = .clear
        subTitleLabel.lineBreakMode = .byWordWrapping

        // Configurează tabelul
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        tableView.separatorColor = .darkGray
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        // Important: Setează aceste valori la zero pentru a evita problemele de auto-sizing
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.layer.cornerRadius = 10

        // Adaugă subview-urile
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(tableView)

        // Configurează constrângerile pentru subview-uri
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(30)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }

        // Configurează constrângerile pentru table view
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(options.count * 50) // 4 opțiuni * 50
            make.width.equalToSuperview().multipliedBy(0.99)
            make.bottom.lessThanOrEqualToSuperview().offset(-20).priority(.low)
        }
    }
}

extension ExercisesMax: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configurează celula
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        cell.selectionStyle = .none
        
        // Afișează checkmark pentru celula selectată
        cell.accessoryType = (selectedIndex == indexPath.row) ? .checkmark : .none
        cell.tintColor = .systemBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // Înălțimea fixă pentru fiecare celulă
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Actualizează indexul selectat
        selectedIndex = indexPath.row
        tableView.reloadData()
        
        // Trimite selecția prin closure
        selectionHandler?(indexPath.row)
    }
}
