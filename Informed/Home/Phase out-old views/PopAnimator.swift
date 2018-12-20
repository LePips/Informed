//
//  PopAnimator.swift
//  Informed
//
//  Created by Ethan Pippin on 11/16/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let cardView = presenting ? toView: transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : cardView.frame
        let finalFrame = presenting ? cardView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            cardView.transform = scaleTransform
            cardView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            cardView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: cardView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, animations: {
            cardView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            cardView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
    }

}

