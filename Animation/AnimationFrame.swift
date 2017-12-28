//
//  frame.swift
//  Animation
//
//  Created by Alexandr Gavrishev on 28/12/2017.
//  Copyright © 2017 Anodsplace. All rights reserved.
//

import UIKit

struct FrameData {
    let pic: UIImage
    let title: String
}

class AnimationFrame: UIView {
    static let frameSize = CGRect(x: 0, y: 0, width: 300, height: 350)

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UILabel!
    
    static func create(data: FrameData) -> AnimationFrame {
        let frame = AnimationFrame(frame: AnimationFrame.frameSize)
        frame.image.image = data.pic
        frame.text.text = data.title
        return frame
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.inflate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.inflate()
    }
    
    func inflate() {
        let view = Bundle.main.loadNibNamed("AnimationFrame", owner: self, options: nil)!.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

}
