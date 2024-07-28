//
//  RatingView.swift
//  MovieDataApplication
//
//  Created by apple on 29/07/24.
//

import UIKit

class RatingView: UIView {
    
    private let ratingLabel = UILabel()
    
    var ratingValue: String? {
        didSet {
            ratingLabel.text = ratingValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
