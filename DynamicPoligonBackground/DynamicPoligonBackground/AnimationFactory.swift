//
//  AnimationFactory.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

internal class AnimationFactory {
    private var randomDuration: Double {
        let duration = Double(arc4random_uniform(2) + 1) / 2
        return duration
    }
    private var randomDelay: Double {
        
        let delay = Double(arc4random_uniform(20) + 2)
        return delay
    }
    private var flipAnimationPool: List<FlipAnimation> = List<FlipAnimation>() {
        didSet {
            if self.flipAnimationPool.count > self.maximumPoolSize {
                self.flipAnimationPool.removeLast()
            }
        }
    }
    private var changeColorAnimationPool: List<ChangeColorAnimation> = List<ChangeColorAnimation>() {
        didSet {
            if self.changeColorAnimationPool.count > self.maximumPoolSize {
                self.changeColorAnimationPool.removeLast()
            }
        }
    }
    private var changeAlphaAnimationPool: List<ChangeAlphaAnimation> = List<ChangeAlphaAnimation>() {
        didSet {
            if self.changeAlphaAnimationPool.count > self.maximumPoolSize {
                self.changeAlphaAnimationPool.removeLast()
            }
        }
    }
    private var dropAnimationPool: List<DropAnimation> = List<DropAnimation>() {
        didSet {
            if self.dropAnimationPool.count > self.maximumPoolSize {
                self.dropAnimationPool.removeLast()
            }
        }
    }
    private var shrinkAnimationPool: List<ShrinkAnimation> = List<ShrinkAnimation>() {
        didSet {
            if self.shrinkAnimationPool.count > self.maximumPoolSize {
                self.shrinkAnimationPool.removeLast()
            }
        }
    }
    internal var countEstimatedObjectsToAnimate: Int = 0
    private var maximumPoolSize: Int {
        return self.countEstimatedObjectsToAnimate / 2
    }
    
    private func getPool(forAnimationType type: AnimationType) -> NSMutableArray{
        switch type {
        case .ChangeAlpha:
            return self.changeAlphaAnimationPool.list
        case .ChangeColor:
            return self.changeColorAnimationPool.list
        case .Drop:
            return self.dropAnimationPool.list
        case .Flip:
            return self.flipAnimationPool.list
        case .Shrink:
            return self.shrinkAnimationPool.list
        }
    }
    
    internal func makeAnimation(target: Animateable) {
        self.privateMakeAnimation(target, isBrandNewClient: true)
    }
    
    private func privateMakeAnimation(target: Animateable, isBrandNewClient new: Bool) {
        var animation: AbstractAnimation?
        self.countEstimatedObjectsToAnimate++
        
        let type: AnimationType!
        
        if new {
            type = AnimationType.ChangeColor
        }
        else {
            type = AnimationType.random()
        }
        
        animation = self.setAnimation(forTarget: target, AnimationType: type)
        
        animation?.animate()
    }
    
    private func setAnimation(forTarget target: Animateable, AnimationType type: AnimationType) -> AbstractAnimation {
        var animation: AbstractAnimation!
        var pool = self.getPool(forAnimationType: type)
        
        if pool.count <= 0 {
            animation = AnimationType.animation(forType: type, forTarget: target)
        }
        else {
            animation = pool.lastObject as! AbstractAnimation
            pool.removeLastObject()
        }
        
        animation.target = target
        animation.randomDelay = self.randomDelay
        animation.randomDuration = self.randomDuration
        animation.reuse = {
            self.privateMakeAnimation(animation.target!, isBrandNewClient: false)
            self.reuse(animation)
        }
        
        return animation
    }

    private func reuse(animation: AbstractAnimation) {
        self.countEstimatedObjectsToAnimate--
        
        switch animation.type! {
        case .ChangeAlpha:
            self.changeAlphaAnimationPool.insert(animation as! ChangeAlphaAnimation)
        case .ChangeColor:
            self.changeColorAnimationPool.insert(animation as! ChangeColorAnimation)
        case .Drop:
            self.dropAnimationPool.insert(animation as! DropAnimation)
        case .Flip:
            self.flipAnimationPool.insert(animation as! FlipAnimation)
        case .Shrink:
            self.shrinkAnimationPool.insert(animation as! ShrinkAnimation)
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