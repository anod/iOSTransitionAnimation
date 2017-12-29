//
//  TransitionSequence.swift
//  Animation
//
//  Created by Alexandr Gavrishev on 29/12/2017.
//  Copyright © 2017 Anodsplace. All rights reserved.
//

import UIKit

// Fram infromation
protocol Frame {
    
}

// Factory for a view which will be filled with Frame information
protocol FrameView {
    func create(frame: Frame) -> UIView
}

protocol TransitionSequnece {
    // Container where animation will be performed
    weak var container: UIView? { get }
    
    // Frame view factory
    var frameView: FrameView { get }
    // Frames infromation
    var frames: [Frame] { get }
    
    // Options to pass to UIView.transition, default [ .transitionCurlUp ]
    var transitionOptions: UIViewAnimationOptions { get set }
    
    // Start animate transion inside container with frames rendered in frame view
    func start(completion: ((_ finished: Bool) -> Void)?)
    func stop()
}

class FrameTransitionSequence: TransitionSequnece {
    weak var container: UIView?
    
    var transitionOptions: UIViewAnimationOptions = [ .transitionCurlUp ]
    
    let frameView: FrameView
    let frames: [Frame]
    
    private var index = 0
    private var currentFrame: UIView?
    private var nextFrame: UIView?
    private var running = true
    
    init(container: UIView, frameView: FrameView, frames: [Frame]) {
        self.container = container
        self.frameView = frameView
        self.frames = frames
    }
    
    func start(completion: ((Bool) -> Void)?) {
        assert(self.frames.count > 0)
        if (self.frames.count == 0) {
            completion?(true)
            return
        }
        self.currentFrame = self.frameView.create(frame: self.frames[0])
        guard let initialFrame = self.currentFrame else {
            completion?(false)
            return
        }
        self.container?.addSubview(initialFrame)
        if (self.frames.count == 1) {
            completion?(true)
            return
        }
        self.running = true
        self.runSequence(completion: completion)
    }
    
    func stop() {
        self.running = false
    }
    
    private func runSequence(completion: ((Bool) -> Void)?) {
        self.index += 1
        if (self.index < self.frames.count) {
            if (!self.running) {
                completion?(false)
                return
            }

            self.nextFrame = self.frameView.create(frame: self.frames[self.index])
            self.animate() { finished in
                self.currentFrame = self.nextFrame
                self.runSequence(completion: completion)
            }
        } else {
            completion?(true)
        }
    }
    
    private func animate(completion: @escaping (Bool) -> Void) {
        guard let container = self.container else {
            completion(false)
            return
        }
        
        UIView.transition(with: container, duration: 1.0, options: self.transitionOptions, animations: {
            self.currentFrame?.removeFromSuperview()
            
            if let backView = self.nextFrame {
                self.container?.addSubview(backView)
            }
        }, completion: completion)
    }
}
