//
//  ChangeColorAnimation.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class ChangeColorAnimation: AbstractAnimation {
    internal var colorSet: [UIColor] {
        if self.target?.colorSet == nil {
            return ChangeColorAnimation.defaultColorSet
        }
        else {
            return self.target!.colorSet!
        }
    }
    internal var pickRandomColor: UIColor {
        let index = Int(arc4random_uniform(UInt32(self.colorSet.count)))
        return self.colorSet[index]
    }
    override var type: AnimationType? {
        return AnimationType.ChangeColor
    }
    
    override func animation() {
        self.target!.alpha = 0
    }
    
    override func completion(result: Bool) {
        UIView.animateWithDuration(1, animations: {
            self.target!.alpha = 1
            self.target!.backgroundColor = self.pickRandomColor
            }, completion: { result in
                super.completion(result)
        })
    }
    
    class var defaultColorSet: [UIColor] {
        struct wrap {
            static let colorSet: [UIColor] = [UIColor.whiteColor(), UIColor.grayColor(), UIColor.blackColor(), UIColor.lightTextColor(), UIColor.lightGrayColor(), UIColor.darkGrayColor()]
        }
        
        return wrap.colorSet
    }
}