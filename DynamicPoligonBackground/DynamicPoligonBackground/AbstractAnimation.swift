//
//  AbstractAnimation.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class AbstractAnimation {
    
    internal var randomDuration: Double = 0
    internal var randomDelay: Double = 0
    internal var animationOptions: UIViewAnimationOptions = UIViewAnimationOptions.CurveLinear
    internal var target: Animateable? 
    internal var reuse: (() -> ())?
    internal var type: AnimationType? {
        return nil
    }
    
    required internal init(target: Animateable) {
        self.target = target
    }
    
    internal func animation() {}
    
    internal func completion(result: Bool) {
        self.reuse?()
    }
    
    internal func animate() {
        UIView.animateWithDuration(self.randomDuration, delay: self.randomDelay, options: self.animationOptions, animations: self.animation, completion: self.completion)
    }
}