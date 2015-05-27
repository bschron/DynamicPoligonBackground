//
//  ShrinkAnimation.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/27/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class ShrinkAnimation: AbstractAnimation {
    
    private var originalSize: CGSize?
    private var originalOrigin: CGPoint?
    override var type: AnimationType? {
        return AnimationType.Shrink
    }
    
    override func animation() {
        self.originalSize = self.target!.frame.size
        self.originalOrigin = self.target!.frame.origin
        
        self.target!.frame.origin.x += self.target!.frame.width / 2
        self.target!.frame.origin.y += self.target!.frame.height / 2
        self.target!.frame.size.height = 0
        self.target!.frame.size.width = 0
        self.target!.layoutSubviews()
        self.target!.hide()
    }
    
    override func completion(result: Bool) {
        self.target!.frame.origin = self.originalOrigin!
        self.target!.frame.size = self.originalSize!
        self.target!.layoutSubviews()
        
        UIView.animateWithDuration(2, delay: 6, options: self.animationOptions, animations: {
            self.target!.show()
            }, completion: { result in
                super.completion(result)
        })
    }
}
