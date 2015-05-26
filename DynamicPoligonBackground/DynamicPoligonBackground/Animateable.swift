//
//  Animateable.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/26/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import Foundation
import UIKit

class Animateable: UIView {
    var colorSet: [UIColor]?
    func hide(){
        self.alpha = 0
    }
    func show(){
        self.alpha = 1
    }
}