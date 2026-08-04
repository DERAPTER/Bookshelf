//
//  PreviewView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.05.2026.
//

import UIKit
import Lottie

class PreviewView: UIViewController {
    
    var state: WindowCase = .reg
    
    lazy var lottieView: LottieAnimationView = {
        $0.frame.size = CGSize(width: view.frame.width - 80, height: view.frame.width - 80)
        $0.center = view.center
        $0.loopMode = .loop
        return $0
    }(LottieAnimationView(name: "bookAnimation"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgMain
        view.addSubview(lottieView)
        
        if let stateRaw = UserDefaults.standard.string(forKey: "state") {
            if let state = WindowCase(rawValue: stateRaw) {
                self.state = state
            }
        }
        
        lottieView.play(fromFrame: 0, toFrame: 240, loopMode: .playOnce) { _ in
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: self.state])
        }
    }
    
}

