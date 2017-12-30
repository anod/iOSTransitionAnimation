//
//  ViewController.swift
//  Animation
//
//  Created by Alexandr Gavrishev on 25/12/2017.
//  Copyright © 2017 Anodsplace. All rights reserved.
//

import UIKit
import ViewTransitionSequence

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
    
    var sequence: TransitionSequnece!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sequence = ViewTransitionSequence(container: self.container, frameView: AnimationFrameView(), frames: frames)
        self.sequence.start() { finished in
            print("Sequence finished \(finished)")
        }
    }
}

