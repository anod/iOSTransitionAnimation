//
//  ViewController.swift
//  Animation
//
//  Created by Alexandr Gavrishev on 25/12/2017.
//  Copyright © 2017 Anodsplace. All rights reserved.
//

import UIKit

let frames: [FrameData] = [
    FrameData(pic: UIImage(named: "face-1")!, title: "Best beard"),
    FrameData(pic: UIImage(named: "face-2")!, title: "Weird glass"),
    FrameData(pic: UIImage(named: "face-3")!, title: "Funny"),
    FrameData(pic: UIImage(named: "face-4")!, title: "Boring"),
    FrameData(pic: UIImage(named: "face-5")!, title: "Geek"),
    FrameData(pic: UIImage(named: "face-6")!, title: "Best friend"),
]

class ViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    
    var currentFrame = AnimationFrame.create(data: frames[0])
    var nextFrame: AnimationFrame!
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.container.addSubview(self.currentFrame)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.run()
        }
        
    }
        
    func run() {
        self.index += 1
        if (self.index < frames.count) {
            self.nextFrame = AnimationFrame.create(data: frames[self.index])
            self.animate() { finished in
                self.currentFrame = self.nextFrame
                self.run()
            }
        }
    }

    func animate(completion: @escaping (Bool) -> Void) {
        
        
        // create a 'tuple' (a pair or more of objects assigned to a single variable)
        let views = (frontView: currentFrame, backView: nextFrame)
        
        UIView.transition(with: self.container, duration: 1.0, options: [ .transitionCurlUp ], animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.container.addSubview(views.backView)
            
        }, completion: completion)
    }
}

