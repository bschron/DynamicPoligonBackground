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
        return self.frame.height / self.poligonHeight
    }
    private let poligonsPerLine: CGFloat = 5
    private let firstLineColorSet: [UIColor] = [RGBColor(r: 5, g: 16, b: 96, alpha: 1), RGBColor(r: 9, g: 20, b: 123, alpha: 1), RGBColor(r: 12, g: 24, b: 125, alpha: 1), RGBColor(r: 11, g: 24, b: 145, alpha: 1), RGBColor(r: 12, g: 25, b: 152, alpha: 1), RGBColor(r: 3, g: 15, b: 183, alpha: 1), RGBColor(r: 5, g: 15, b: 93, alpha: 1)]
    
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
    
    private func colorSet(alphaComponent alpha: CGFloat, forSet set: [UIColor]) -> [UIColor] {
        var newSet: [UIColor] = []
        
        for cur in set {
            newSet += [cur.colorWithAlphaComponent(alpha)]
        }
        
        return newSet
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
                poligon.colorSet = self.colorSet(alphaComponent: 1 / (j / (self.numberOfLines / 2)), forSet: self.firstLineColorSet)
                poligons += [poligon]
                self.addSubview(poligon)
                AnimationFactory.singleton.makeAnimation(poligon)
            }
        }
    }
    
}
