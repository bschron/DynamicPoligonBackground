//
//  AnimationFactory.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

enum AnimationType: Int {
    case Flip = 0, ChangeColor = 1, ChangeAlpha = 2
    static var count: Int {
        return 3
    }
}

internal class AnimationFactory {
    private var randomDuration: Double {
        let duration = Double(arc4random_uniform(2) + 1) / 2
        return duration
    }
    private var randomDelay: Double {
        let delay = Double(arc4random_uniform(12) + 1)
        return delay
    }
    private var randomAnimationType: AnimationType.RawValue {
        return Int(arc4random_uniform(UInt32(AnimationType.count)))
    }
    private var flipAnimationPool: [FlipAnimation] = [] {
        didSet {
            if self.flipAnimationPool.count > self.maximumPoolSize {
                self.flipAnimationPool.removeLast()
            }
        }
    }
    private var changeColorAnimationPool: [ChangeColorAnimation] = [] {
        didSet {
            if self.changeColorAnimationPool.count > self.maximumPoolSize {
                self.changeColorAnimationPool.removeLast()
            }
        }
    }
    private var changeAlphaAnimationPool: [ChangeAlphaAnimation] = [] {
        didSet {
            if self.changeAlphaAnimationPool.count > self.maximumPoolSize {
                self.changeAlphaAnimationPool.removeLast()
            }
        }
    }
    internal var countEstimatedObjectsToAnimate: Int = 6
    private var maximumPoolSize: Int {
        return self.countEstimatedObjectsToAnimate / 2
    }
    
    private func makeFlipAnimation(target: Animateable) -> AbstractAnimation {
        var animation: AbstractAnimation!
        let reuseFunction: () -> () = {
            self.privateMakeAnimation(animation.target!, isBrandNewClient: false)
            self.reuse(animation)
        }
        
        if self.flipAnimationPool.count <= 0 {
            animation = FlipAnimation(target: target)
        }
        else {
            animation = self.flipAnimationPool.last!
            self.flipAnimationPool.removeLast()
        }
        
        animation.reuse = reuseFunction
        
        return animation
    }
    
    private func makeChangeColorAnimation(target: Animateable) -> AbstractAnimation {
        var animation: AbstractAnimation!
        let reuseFunction: () -> () = {
            self.privateMakeAnimation(animation.target!, isBrandNewClient: false)
            self.reuse(animation)
        }
        if self.changeColorAnimationPool.count <= 0 {
            animation = ChangeColorAnimation(target: target)
        }
        else {
            animation = self.changeColorAnimationPool.last!
            self.changeColorAnimationPool.removeLast()
        }
        
        animation.reuse = reuseFunction
        
        return animation
    }
    
    private func makeChangeAlphaAnimation(target: Animateable) -> AbstractAnimation {
        var animation: AbstractAnimation!
        let reuseFunction: () -> () = {
            self.privateMakeAnimation(animation.target!, isBrandNewClient: false)
            self.reuse(animation)
        }
        if self.changeAlphaAnimationPool.count <= 0 {
            animation = ChangeAlphaAnimation(target: target)
        }
        else {
            animation = self.changeAlphaAnimationPool.last!
            self.changeAlphaAnimationPool.removeLast()
        }
        
        animation.reuse = reuseFunction
        
        return animation
    }
    
    internal func makeAnimation(target: Animateable) {
        self.privateMakeAnimation(target, isBrandNewClient: true)
    }
    
    private func privateMakeAnimation(target: Animateable, isBrandNewClient new: Bool) {
        var animation: AbstractAnimation?
        
        if new {
            animation = self.makeChangeColorAnimation(target)
        }
        else {
            switch randomAnimationType {
            case AnimationType.Flip.rawValue:
                animation = self.makeFlipAnimation(target)
            case AnimationType.ChangeColor.rawValue:
                animation = self.makeChangeColorAnimation(target)
            case AnimationType.ChangeAlpha.rawValue:
                animation = self.makeChangeAlphaAnimation(target)
            default:
                animation = nil
            }
        }
        
        animation?.target = target
        animation?.randomDelay = self.randomDelay
        animation?.randomDuration = self.randomDuration
        animation?.animate()
    }

    private func reuse(animation: AbstractAnimation) {
        if animation is FlipAnimation {
            self.flipAnimationPool += [animation as! FlipAnimation]
        }
        else if animation is ChangeAlphaAnimation {
            self.changeAlphaAnimationPool += [animation as! ChangeAlphaAnimation]
        }
        else if animation is ChangeColorAnimation {
            self.changeColorAnimationPool += [animation as! ChangeColorAnimation]
        }
        
        animation.target = nil
        animation.reuse = nil
    }
    
    // MARK: -Static Properties and Methods
    class var singleton: AnimationFactory {
        struct wrap {
            static let singleton: AnimationFactory = AnimationFactory()
        }
        return wrap.singleton
    }
}