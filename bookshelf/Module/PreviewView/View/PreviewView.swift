//
//  PreviewView.swift
//  bookshelf
//
//  Created by Егор Халиков on 17.05.2026.
//

import UIKit
import Lottie

class PreviewView: UIViewController {
    
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
        lottieView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.reg])
        }
    }
    
}

