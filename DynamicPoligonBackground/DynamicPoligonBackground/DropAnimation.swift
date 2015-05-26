//
//  DropAnimation.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/26/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class DropAnimation: AbstractAnimation {
    
    override var randomDuration: Double {
        get {
            return Double(self.fall * 0.01)
        }
        set {}
    }
    override var randomDelay: Double {
        didSet {
            self.lastDelay = self.randomDelay
        }
    }
    private var lastDelay: Double?
    private var originalY: CGFloat?
    private var fall: CGFloat {
        return self.target!.frame.height * 10
    }
    
    override func animation() {
        self.originalY = self.target!.frame.origin.y
        self.target!.frame.origin.y = self.fall
        self.target!.hide()
    }
    
    override func completion(result: Bool) {
        self.target!.frame.origin.y = self.originalY!
        UIView.animateWithDuration(self.randomDuration, delay: self.lastDelay! / 6, options: self.animationOptions, animations: {
            self.target!.show()
            }, completion: { result in
                super.completion(true)
        })
    }
}
