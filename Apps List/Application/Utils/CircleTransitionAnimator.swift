//
//  CircleTransitionAnimator.swift
//  CircleTransition
//
//  Created by Giovanny Orozco on 3/7/16.
//  Copyright © 2016 Rounak Jain. All rights reserved.
//

import UIKit

protocol CircleTransitionableController {
    
    var sourceView: UIView { get }
}

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView()!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UINavigationController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let sourceView = (fromViewController.viewControllers.last as! CircleTransitionableController).sourceView
        
        containerView.addSubview(toViewController.view)
        
        let circleMaskPathInitial = UIBezierPath(ovalInRect: sourceView.frame)
        let extremePoint = CGPoint(x: sourceView.center.x, y: sourceView.center.y)
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(sourceView.frame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) { 
        
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}
