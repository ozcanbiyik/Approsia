//
//  AnimationVC.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 15.01.2022.
//

import UIKit
import Lottie

class AnimationVC: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieAnimation()
        // Do any additional setup after loading the view.
    }
    func lottieAnimation(){
        let animationView = AnimationView(name: "24064-food-squeeze-with-burger-and-hot-dog")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .loop
    }
}
