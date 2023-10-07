//
//  WTCityView.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import UIKit

class WTCityView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
    }
    
    private func initSubViews() {
        // Load nib
        let nib = UINib(nibName: String(describing: type(of: self)),
                        bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self,
                        options: nil)
        
        // Add container view and constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: containerView.topAnchor),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    func configure(with cityViewModel: WTCityViewModel?) {
        headingLabel.text = cityViewModel?.heading ?? ""
        subHeadingLabel.text = cityViewModel?.subHeading ?? ""
        descriptionLabel.text = cityViewModel?.description ?? ""
        
        if let urlString = cityViewModel?.iconUrlString,
           let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async { [weak self] in
                        self?.iconImageView.image = UIImage(data: data)
                    }
                } catch let error {
                    print("icon download error \(error)")
                }
            }
        }
    }
    
}
