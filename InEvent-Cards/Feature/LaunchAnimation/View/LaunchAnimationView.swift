//
//  LaunchAnimationView.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import UIKit
import Lottie

class LaunchAnimationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "lauchscreen.json")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundColor = .black
        animation.animationSpeed = 2.0
        animation.loopMode = .playOnce
        animation.contentMode = .scaleAspectFit
        return animation
    }()
    
    func setUpView() {
        backgroundColor = .systemBackground
        addSubview(animationView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
        
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        
        ])
    }
}
