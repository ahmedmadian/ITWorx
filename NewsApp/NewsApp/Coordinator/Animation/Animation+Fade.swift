//
//  Animation+Fade.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/10/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import XCoordinator

let defaultAnimationDuration: TimeInterval = 0.35

extension Animation {
    static let fade = Animation(
        presentation: InteractiveTransitionAnimation.fade,
        dismissal: InteractiveTransitionAnimation.fadeDismissal
    )
}

extension InteractiveTransitionAnimation {
    fileprivate static let fade = InteractiveTransitionAnimation(duration: defaultAnimationDuration) { transitionContext in
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        toView.alpha = 0.0
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: [.curveEaseIn], animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    fileprivate static let fadeDismissal = InteractiveTransitionAnimation(duration: defaultAnimationDuration) { transitionContext in
        let fromView: UIView = transitionContext.view(forKey: .from)!
        
        fromView.alpha = 1.0
        fromView.removeFromSuperview()
        
        UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: [.curveEaseOut], animations: {
            fromView.alpha = 0.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
