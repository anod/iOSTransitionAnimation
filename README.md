# ViewTransitionSequence

Wrapper on top of UIView transition to animate sequence of views

## Example of usage
```swift
import ViewTransitionSequence


self.sequence = ViewTransitionSequence(
    container: self.container, // container view
    frameView: AnimationFrameView(), // frame view factory 
    frames: [ 
       FrameData(pic: UIImage(named: "face-1")!, title: "Best beard"),
       FrameData(pic: UIImage(named: "face-2")!, title: "Weird glass")
    ])
self.sequence.start() { finished in
    print("Sequence finished \(finished)")
}
 ```
 
## Result
![Sample](https://raw.githubusercontent.com/anod/iOSTransitionAnimation/master/sample.gif)
 
## Options
```swift
public protocol TransitionSequneceOptions {
    // Options to pass to UIView.transition, default [ .transitionCurlUp ]
    var transition: UIViewAnimationOptions { get set }
    // Default 1.0
    var frameDuration: TimeInterval { get set }
}
```
 
## Instaltion
### Carthage
```Cartfile
github "anod/iOSTransitionAnimation" >= 0.1
```
