//
//  ViewController.swift
//  SampleLockAnimationApper
//
//  Created by Hassan Azhar on 14/11/2023.
//

import UIKit
enum PendulumState {
    case max, min
}
class ViewController: UIViewController {
    
    @IBOutlet weak var lockImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
        var newPoint: CGPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint: CGPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)

        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)

        var position: CGPoint = view.layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.anchorPoint = anchorPoint
        view.layer.position = position
    }
    func animatePendulum() {
        let numberOfFrames: Double = 6
        let frameDuration = Double (1/numberOfFrames)
        var duration: Double = 2
        var angle: CGFloat = .pi/8
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration, animations: {
                self.lockImg.transform = CGAffineTransform(rotationAngle: +angle)
            })
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration, animations: {
                self.lockImg.transform = CGAffineTransform(rotationAngle: -angle)
            })
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2, relativeDuration: frameDuration, animations: {
                self.lockImg.transform = CGAffineTransform(rotationAngle: +angle)
            })
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3, relativeDuration: frameDuration, animations: {
                self.lockImg.transform = CGAffineTransform(rotationAngle: -angle)
            })
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4, relativeDuration: frameDuration, animations: {
                self.lockImg.transform = CGAffineTransform(rotationAngle: +angle)
            })
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5, relativeDuration: frameDuration, animations: {
                self.lockImg.transform = .identity
            })
        }, completion: { _ in
            
        })
    }
    func shakeWith(duration: Double = 2.5, angle: CGFloat = .pi/10, completion: @escaping (Bool)->Void) {
        
        let numberOfFrames: Double = 14
        let frameDuration = Double(1/numberOfFrames)
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 0), view: self.lockImg)
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.4, animations: {
            self.lockImg.transform = CGAffineTransform(rotationAngle: -angle)
        })
        
        animator.addAnimations({
            self.lockImg.transform = CGAffineTransform(rotationAngle: +angle)
        }, delayFactor: 0.0)
        animator.addAnimations({
            self.lockImg.transform = CGAffineTransform(rotationAngle: -angle)
        }, delayFactor: frameDuration*2)
        animator.addAnimations({
            self.lockImg.transform = CGAffineTransform(rotationAngle: +angle)
        }, delayFactor: frameDuration*3)
        animator.addAnimations({
            self.lockImg.transform = CGAffineTransform(rotationAngle: -angle)
        }, delayFactor: frameDuration*4)
        animator.addAnimations({
            self.lockImg.transform = CGAffineTransform(rotationAngle: +angle)
        }, delayFactor: frameDuration*3)
        animator.addAnimations({
            self.lockImg.transform = .identity
        }, delayFactor: frameDuration*2)
        animator.addCompletion { post in
            completion(true)
        }
        animator.startAnimation()
        
    }
    @IBAction func ACTIONBTN(_ sender: Any) {
        animatePendulum()
    }
    
    @IBAction func actionbutton2(_ sender: Any) {
        shakeWith { success in
            
        }
    }
    
}
