//
//  FlipAnimation.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class FlipAnimation: AbstractAnimation {
    
    override var randomDuration: Double {
        didSet {
            self.lastDuration = self.randomDuration
        }
    }

    private var originalHeight: CGFloat?
    private var lastDuration: Double?
    private var originalY: CGFloat?
    
    override func animation() {
        self.originalHeight = self.target!.frame.height
        self.originalY = CGFloat(self.target!.frame.origin.y)
        self.target!.frame.origin.y = CGFloat(self.target!.center.y)
        self.target!.frame.size.height = 0
        self.target!.layoutSubviews()
    }
    
    override func completion(result: Bool) {
        UIView.animateWithDuration(self.lastDuration!, delay: 0.0, options: self.animationOptions, animations: {
            self.target!.frame.size.height = self.originalHeight!
            self.target!.frame.origin.y = self.originalY!
            self.target!.layoutSubviews()
            }, completion: { result in
                super.completion(true)
        })
    }
}

