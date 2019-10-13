//
//  SlideInTransition.swift
//  TestPrjAttract
//
//  Created by Надежда Возна on 10.10.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var isPresenting = false
    private var dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toVC.view.bounds.width * 0.8
        let finalHeight = toVC.view.bounds.height
        
        if isPresenting {
            
            //Add dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            //Add menu view controller to container
            containerView.addSubview(toVC.view)
            
            //Init frame off the screen
            toVC.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Move on screen
        let transform = {
            self.dimmingView.alpha = 0.6
            toVC.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //Move back off screen
        let identity = {
            self.dimmingView.alpha = 0.0
            fromVC.view.transform = .identity
        }
        
        //Animation of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations:     {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
    
}
