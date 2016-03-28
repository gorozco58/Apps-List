//
//  ViewControllerAnimator.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/28/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit

private func transitionTime() -> NSTimeInterval {
    return 0.5
}

class ViewControllerPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionTime()
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        toView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(transitionTime(), delay:0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            toView.frame = fromView.frame
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class ViewControllerDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionTime()
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        fromView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        containerView.addSubview(toView)
        containerView.sendSubviewToBack(toView)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ 
          
            UIView.animateWithDuration(transitionTime(), animations: {
                fromView.transform = CGAffineTransformMakeScale(0.01, 0.01)
                }, completion: { _ in
                    transitionContext.completeTransition(true)
            })
        })
        
        fromView.addCornerRadiusAnimation(0, to: 100, duration: transitionTime() / 100)
        
        CATransaction.commit()
    }
}

extension UIView {
    
    func addCornerRadiusAnimation(from: CGFloat, to: CGFloat, duration: CFTimeInterval) {
        
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        layer.addAnimation(animation, forKey: "cornerRadius")
        layer.cornerRadius = to
        layer.masksToBounds = true
    }
}
