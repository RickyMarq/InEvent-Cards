//
//  LaunchAnimationController.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import UIKit

class LaunchAnimationController: UIViewController {
    
    var launchAnimationView: LaunchAnimationView?
    var wasAnimated = false
    
    override func loadView() {
        launchAnimationView = LaunchAnimationView()
        view = launchAnimationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        launchAnimationView?.setUpView()
        launchAnimationView?.setUpConstraints()
        
        launchAnimationView?.animationView.play(completion: { finished in
            if finished {
                self.transitionToMain()
            }
        })
    }
}

extension LaunchAnimationController {
    
    func transitionToMain() {
        let mainVc = CardController()
        mainVc.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(mainVc, animated: true)
    }
}
