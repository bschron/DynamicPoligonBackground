//
//  AnimationType.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/26/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation

internal enum AnimationType: UInt32 {
    case Flip, ChangeColor, ChangeAlpha, Drop
    
    static func count() -> UInt32 {
        var maxValue: UInt32 = 0
        while let _ = self(rawValue: ++maxValue) {}
        return maxValue
    }
    
    static func animation(forType type: AnimationType, forTarget target: Animateable) -> AbstractAnimation {
        let animation: AbstractAnimation!
        switch type {
        case .ChangeAlpha:
            animation = ChangeAlphaAnimation(target: target)
        case .ChangeColor:
            animation = ChangeColorAnimation(target: target)
        case .Flip:
            animation = FlipAnimation(target: target)
        case .Drop:
            animation = DropAnimation(target: target)
        }
        
        return animation
    }
    
    static func random() -> AnimationType {
        let rand = arc4random_uniform(self.count())
        return self(rawValue: rand)!
    }
}