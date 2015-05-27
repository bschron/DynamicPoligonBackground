//
//  DynamicPoligonBackground.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/23/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import UIKit

class DynamicPoligonBackground: UIView {
    
    private var poligonWidth: CGFloat {
        return self.frame.width / self.poligonsPerLine
    }
    private var poligonHeight: CGFloat {
        return self.poligonWidth / 1.5
    }
    private var poligons: [DiamondView] = []
    private var numberOfLines: CGFloat {
        return self.frame.height / self.poligonHeight * 1.2
    }
    private let poligonsPerLine: CGFloat = 5
    
    private func numberOfPoligons(forLine line: Int) -> Int {
        if line == 0 {
            return Int(self.poligonsPerLine)
        }
        else if line % 2 != 0 {
            return Int(self.poligonsPerLine) + 2
        }
        else {
            return Int(self.poligonsPerLine)
        }
    }
    private var gradient: CAGradientLayer?
    
    private func colorSet(alphaComponent alpha: CGFloat, forSet set: [UIColor]) -> [UIColor] {
        var newSet: [UIColor] = []
        
        for cur in set {
            newSet += [cur.colorWithAlphaComponent(alpha)]
        }
        
        return newSet
    }
    
    private func colorSet(forLine line: Int) -> [UIColor] {
        let progression = self.lineProgression(forLine: CGFloat(line))
        let set: [UIColor]!
        
        if progression < 0.25 {
            set = DynamicPoligonBackground.firstLineColorSet
        }
        else if progression < 0.4 {
            set = DynamicPoligonBackground.secondLineColorSet
        }
        else if progression < 0.6 {
            set = DynamicPoligonBackground.thirdLineColor
        }
        else if progression < 0.8 {
            set = DynamicPoligonBackground.fourthLineColor
        }
        else {
            set = DynamicPoligonBackground.lastLineColorSet
        }
        
        return set
    }
    
    private func lineProgression(forLine line: CGFloat) -> CGFloat {
        return line / self.numberOfLines
    }
    
    private func setBackgroundColor() {
        var vista = self
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = vista.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        let cor1 = UIColor.whiteColor().CGColor
        let cor2 = UIColor.whiteColor().CGColor
        let cor3 = UIColor.whiteColor().CGColor
        let cor4 = UIColor.whiteColor().CGColor
        let cor5 = UIColor.whiteColor().CGColor
        let cor6 = RGBColor(r: 252, g: 244, b: 241, alpha: 1).CGColor
        let cor7 = RGBColor(r: 239, g: 231, b: 214, alpha: 1).CGColor
        
        gradient.colors = [cor1, cor2, cor3, cor4, cor5, cor6, cor7]
        self.gradient?.removeFromSuperlayer()
        vista.layer.insertSublayer(gradient, atIndex: 0)
        
        self.gradient = gradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for cur in self.poligons {
            cur.removeFromSuperview()
        }
        
        let poligonWidth = self.poligonWidth
        let poligonHeight = self.poligonHeight
        for var j: CGFloat = 0; j < numberOfLines; j++ {
            let numberOfPoligons = CGFloat(self.numberOfPoligons(forLine: Int(j)))
            for var i: CGFloat = 0; i < numberOfPoligons; i++ {
                var x = numberOfPoligons == poligonsPerLine ? poligonWidth * i : (poligonWidth * i) - (poligonWidth / 2)
                let y = (poligonHeight / 2) * j - (poligonHeight / 2)
                
                let poligon = DiamondView(frame: CGRect(x: x, y: y, width: poligonWidth, height: poligonHeight))
                let colorSet = self.colorSet(forLine: Int(j))
                poligon.colorSet = colorSet
                poligon.backgroundColor = colorSet[Int(arc4random_uniform(UInt32(colorSet.count)))]
                poligon.backgroundColor = colorSet[Int(arc4random_uniform(UInt32(colorSet.count)))]
                poligons += [poligon]
                self.addSubview(poligon)
                AnimationFactory.singleton.makeAnimation(poligon)
            }
        }
        
        self.setBackgroundColor()
    }
    
    // MARK: -Static Properties and Methods
    private class var firstLineColorSet: [UIColor] {
        struct wrap{
            static let colorSet = [RGBColor(r: 5, g: 16, b: 96, alpha: 1), RGBColor(r: 9, g: 20, b: 123, alpha: 1), RGBColor(r: 12, g: 24, b: 125, alpha: 1), RGBColor(r: 11, g: 24, b: 145, alpha: 1), RGBColor(r: 12, g: 25, b: 152, alpha: 1), RGBColor(r: 3, g: 15, b: 183, alpha: 1), RGBColor(r: 5, g: 15, b: 93, alpha: 1)]
        }
        
        return wrap.colorSet
    }
    private class var secondLineColorSet: [UIColor] {
        struct  wrap {
            static let colorSet = [RGBColor(r: 7, g: 71, b: 213, alpha: 1), RGBColor(r: 8, g: 94, b: 229, alpha: 1), RGBColor(r: 8, g: 75, b: 226, alpha: 1), RGBColor(r: 3, g: 31, b: 181, alpha: 1), RGBColor(r: 4, g: 33, b: 186, alpha: 1), RGBColor(r: 2, g: 30, b: 78, alpha: 1), RGBColor(r: 3, g: 28, b: 164, alpha: 1), RGBColor(r: 15, g: 144, b: 240, alpha: 1)]
        }
        
        return wrap.colorSet
    }
    private class var thirdLineColor: [UIColor] {
        struct wrap {
            static let colorSet = [RGBColor(r: 17, g: 148, b: 212, alpha: 1), RGBColor(r: 11, g: 114, b: 203, alpha: 1), RGBColor(r: 13, g: 124, b: 205, alpha: 1), RGBColor(r: 19, g: 170, b: 247, alpha: 1), RGBColor(r: 13, g: 150, b: 242, alpha: 1), RGBColor(r: 15, g: 130, b: 234, alpha: 1), RGBColor(r: 20, g: 168, b: 246, alpha: 1)]
        }
        
        return wrap.colorSet
    }
    private class var fourthLineColor: [UIColor] {
        struct wrap {
            static let colorSet = [RGBColor(r: 31, g: 197, b: 244, alpha: 1), RGBColor(r: 86, g: 210, b: 255, alpha: 1), RGBColor(r: 125, g: 207, b: 254, alpha: 1), RGBColor(r: 172, g: 229, b: 254, alpha: 1), RGBColor(r: 172, g: 227, b: 254, alpha: 1), RGBColor(r: 12, g: 159, b: 249, alpha: 1), RGBColor(r: 66, g: 203, b: 255, alpha: 1), RGBColor(r: 182, g: 226, b: 254, alpha: 1), RGBColor(r: 226, g: 245, b: 255, alpha: 1), RGBColor(r: 66, g: 200, b: 248, alpha: 1)]
        }
        
        return wrap.colorSet
    }
    private class var lastLineColorSet: [UIColor] {
        struct wrap {
            static let colorSet = [RGBColor(r: 202, g: 231, b: 249, alpha: 1), RGBColor(r: 229, g: 243, b: 254, alpha: 1), RGBColor(r: 254, g: 254, b: 254, alpha: 1), RGBColor(r: 229, g: 243, b: 254, alpha: 1).colorWithAlphaComponent(0.5), RGBColor(r: 202, g: 231, b: 249, alpha: 1).colorWithAlphaComponent(0.5), RGBColor(r: 202, g: 231, b: 249, alpha: 1).colorWithAlphaComponent(0.2)]
        }
        
        return wrap.colorSet
    }
    
}
