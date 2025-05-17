import UIKit
import SnapKit

class ProgramsViewController: UIViewController, UIScrollViewDelegate {
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private let contentView = UIView()
    
    // Beginner Section
    private let beginnerLabel: UILabel = {
        let label = UILabel()
        label.text = "Beginner"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let beginnerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return scrollView
    }()
    
    private let beginnerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    // Intermediate Section
    private let intermediateLabel: UILabel = {
        let label = UILabel()
        label.text = "Intermediate"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let intermediateScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return scrollView
    }()
    
    private let intermediateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    // Advanced Section
    private let advancedLabel: UILabel = {
        let label = UILabel()
        label.text = "Advanced"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let advancedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return scrollView
    }()
    
    private let advancedStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Workouts"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 32)
        ]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
        
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        
        setupLayout()
        addBeginnerImages()
        addIntermediateImages()
        addAdvancedImages()
        
        beginnerScrollView.delegate = self
        intermediateScrollView.delegate = self
        advancedScrollView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        
        // Add all labels and scrollviews inside contentView
        contentView.addSubview(beginnerLabel)
        contentView.addSubview(beginnerScrollView)
        beginnerScrollView.addSubview(beginnerStackView)
        
        contentView.addSubview(intermediateLabel)
        contentView.addSubview(intermediateScrollView)
        intermediateScrollView.addSubview(intermediateStackView)
        
        contentView.addSubview(advancedLabel)
        contentView.addSubview(advancedScrollView)
        advancedScrollView.addSubview(advancedStackView)
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview() // important for vertical scrolling
        }
        
        // Layout Beginner
        beginnerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.left.equalToSuperview().offset(15)
        }
        
        beginnerScrollView.snp.makeConstraints { make in
            make.top.equalTo(beginnerLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        beginnerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        // Layout Intermediate
        intermediateLabel.snp.makeConstraints { make in
            make.top.equalTo(beginnerScrollView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(15)
        }
        
        intermediateScrollView.snp.makeConstraints { make in
            make.top.equalTo(intermediateLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        intermediateStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        // Layout Advanced
        advancedLabel.snp.makeConstraints { make in
            make.top.equalTo(intermediateScrollView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(15)
        }
        
        advancedScrollView.snp.makeConstraints { make in
            make.top.equalTo(advancedLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview().offset(-20) // contentView bottom constraint
        }
        
        advancedStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    private func addBeginnerImages() {
        let imageNames = ["beginner_1", "beginner_2", "beginner_3"]
        
        for name in imageNames {
            let imageView = UIImageView()
            imageView.image = UIImage(named: name)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            beginnerStackView.addArrangedSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.width.equalTo(view.frame.width * 0.85)
                make.height.equalTo(250)
            }
        }
    }
    
    private func addIntermediateImages() {
        let imageNames = ["intermediate_1", "intermediate_2", "intermediate_3"]
        
        for name in imageNames {
            let imageView = UIImageView()
            imageView.image = UIImage(named: name)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            intermediateStackView.addArrangedSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.width.equalTo(view.frame.width * 0.85)
                make.height.equalTo(250)
            }
        }
    }
    
    private func addAdvancedImages() {
        let imageNames = ["advanced_1", "advanced_2", "advanced_3"]
        
        for name in imageNames {
            let imageView = UIImageView()
            imageView.image = UIImage(named: name)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            advancedStackView.addArrangedSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.width.equalTo(view.frame.width * 0.85)
                make.height.equalTo(250)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageWidth = view.frame.width * 0.85
        let spacing: CGFloat = 15
        
        // Beginner contentSize
        let beginnerCount = CGFloat(beginnerStackView.arrangedSubviews.count)
        let beginnerContentWidth = imageWidth * beginnerCount + spacing * (beginnerCount - 1)
        beginnerScrollView.contentSize = CGSize(width: beginnerContentWidth, height: beginnerScrollView.frame.height)
        
        // Intermediate contentSize
        let intermediateCount = CGFloat(intermediateStackView.arrangedSubviews.count)
        let intermediateContentWidth = imageWidth * intermediateCount + spacing * (intermediateCount - 1)
        intermediateScrollView.contentSize = CGSize(width: intermediateContentWidth, height: intermediateScrollView.frame.height)
        
        // Advanced contentSize
        let advancedCount = CGFloat(advancedStackView.arrangedSubviews.count)
        let advancedContentWidth = imageWidth * advancedCount + spacing * (advancedCount - 1)
        advancedScrollView.contentSize = CGSize(width: advancedContentWidth, height: advancedScrollView.frame.height)
    }
    
    // Snap scrolling for all horizontal scroll views
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNearestPage(scrollView: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToNearestPage(scrollView: scrollView)
        }
    }
    
    private func snapToNearestPage(scrollView: UIScrollView) {
        let imageWidth = view.frame.width * 0.85
        let spacing: CGFloat = 15
        let pageWidth = imageWidth + spacing
        
        var offset = scrollView.contentOffset.x
        let page = round(offset / pageWidth)
        offset = page * pageWidth
        
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}
