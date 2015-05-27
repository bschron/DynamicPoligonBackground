//
//  ChangeAlphaAnimation.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class ChangeAlphaAnimation: AbstractAnimation {
    
    override var randomDuration: Double {
        didSet {
            self.lastDuration = self.randomDuration
        }
    }
    override var type: AnimationType? {
        return AnimationType.ChangeAlpha
    }

    private var lastDuration: Double?
    
    override func animation() {
        self.target?.alpha = CGFloat(0)
    }
    
    override func completion(result: Bool) {
        UIView.animateWithDuration(self.lastDuration!, delay: self.randomDelay, options: self.animationOptions, animations: {
            self.target?.alpha = CGFloat(1)
            }, completion: { result in
                super.completion(result)
        })
    }
}