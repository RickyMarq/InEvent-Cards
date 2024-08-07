//
//  CardView.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import UIKit

protocol CardViewProtocol: AnyObject {
    func cardButtonAction()
}

class CardView: UIView {
    
    private weak var delegate: CardViewProtocol?
    
    func delegate(delegate: CardViewProtocol) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var cardStack: [UIImageView] = []
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokerTable")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var remainingCardsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Cartas restantes: #"
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var cardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(cardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func cardButtonTapped() {
        delegate?.cardButtonAction()
    }
    
    func updateRemainingCardsLabel(with count: Int) {
        remainingCardsLabel.text = "Cartas restantes: \(count)"
        
        switch count {
        case ..<10:
            remainingCardsLabel.textColor = .red
        case 10..<25:
            remainingCardsLabel.textColor = .yellow
        default:
            remainingCardsLabel.textColor = .green
        }
    }
    
    func updatePreviousCards(with urls: [String]) {
        cardStack.forEach { $0.removeFromSuperview() }
        cardStack = []
        
        for (index, url) in urls.suffix(3).enumerated() {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.kf.setImage(with: URL(string: url))
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(index) * 0.1 - 0.1)
            cardStack.append(imageView)
            addSubview(imageView)
            insertSubview(imageView, belowSubview: cardButton)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: cardButton.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: cardButton.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: cardButton.widthAnchor, multiplier: 0.75 - CGFloat(index) * 0.05),
                imageView.heightAnchor.constraint(equalTo: cardButton.heightAnchor, multiplier: 0.75 - CGFloat(index) * 0.05)
            ])
        }
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    func updateCardButtonImage(with url: String) {
        cardImage.kf.setImage(with: URL(string: url))
    }
}

extension CardView: ViewCode {
    
    func configureSubviews() {
        addSubview(backgroundImageView)
        addSubview(remainingCardsLabel)
        addSubview(cardButton)
        cardButton.addSubview(cardImage)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            remainingCardsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            remainingCardsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            remainingCardsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            remainingCardsLabel.heightAnchor.constraint(equalToConstant: 24),
            
            cardButton.topAnchor.constraint(equalTo: remainingCardsLabel.bottomAnchor, constant: 14),
            cardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            cardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            cardButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            
            cardImage.topAnchor.constraint(equalTo: cardButton.topAnchor),
            cardImage.leadingAnchor.constraint(equalTo: cardButton.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: cardButton.trailingAnchor),
            cardImage.bottomAnchor.constraint(equalTo: cardButton.bottomAnchor)
        ])
    }
    
    func configureAdditionalBehaviors() {
        backgroundColor = .systemBackground
    }
}
