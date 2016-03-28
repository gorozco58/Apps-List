//
//  ViewControllerAnimator.swift
//  Apps List
//
//  Created by Giovanny Orozco on 3/28/16.
//  Copyright © 2016 Giovanny Orozco. All rights reserved.
//

import UIKit

class ViewControllerPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
//        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        toView.alpha = 0
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(0.5, animations: {
            toView.alpha = 1
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

class ViewControllerDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        fromView.alpha = 1
        containerView.addSubview(toView)
        containerView.sendSubviewToBack(toView)
        
        UIView.animateWithDuration(0.5, animations: {
            fromView.alpha = 0
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}
