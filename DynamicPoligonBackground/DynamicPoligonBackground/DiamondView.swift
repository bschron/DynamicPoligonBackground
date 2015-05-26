//
//  DiamondView.swift
//  DynamicPoligonBackground
//
//  Created by Bruno Chroniaris on 5/24/15.
//  Copyright (c) 2015 IC-UFAL. All rights reserved.
//

import UIKit

private extension UIImage {
    
    func tintWithColor(color:UIColor)->UIImage {
        
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        
        // flip the image
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextTranslateCTM(context, 0.0, -self.size.height)
        
        // multiply blend mode
        CGContextSetBlendMode(context, kCGBlendModeMultiply)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        
        // create uiimage
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
}

private enum ColorChangeState {
    case Left, Right
    
    mutating func toggle() {
        switch self {
        case .Left:
            self = .Right
        case .Right:
            self = .Left
        }
    }
}

class DiamondView: Animateable {
    
    private var leftImageView: UIImageView?
    private var rightImageView: UIImageView?
    private var internalBackgroundChange: Bool = false
    private var colorState: ColorChangeState = .Left
    private var _backgroundColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0)
    override var backgroundColor: UIColor? {
        get {
            return self._backgroundColor
        }
        set {
            if newValue != nil {
                switch self.colorState {
                case .Left:
                    self.leftImageView?.image = self.leftImageView?.image?.tintWithColor(newValue!)
                case .Right:
                    self.rightImageView?.image = self.rightImageView?.image?.tintWithColor(newValue!)
                }
                self.colorState.toggle()
            }
        }
    }
    override var alpha: CGFloat {
        get {
            return 1
        }
        set {
            switch self.colorState {
            case .Left:
                self.leftImageView?.alpha = newValue
            case .Right:
                self.rightImageView?.alpha = newValue
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.draw()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.draw()
    }
    
    func draw() {
        let leftView = UIImageView(image: DiamondView.wrap.left)
        let rightView = UIImageView(image: DiamondView.wrap.right)
        self.addSubview(leftView)
        self.addSubview(rightView)
        self.leftImageView = leftView
        self.rightImageView = rightView
        
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rightImageView?.frame = self.bounds
        self.rightImageView?.frame.size.width /= 2
        self.leftImageView?.frame = self.bounds
        self.leftImageView?.frame.size.width /= 2
        self.rightImageView?.frame.origin.x += self.frame.width / 2
    }
    /*
    func animateImage(no:Int)
    {
        var imgNumber: Int = no
        let t:NSTimeInterval = 1;
        let t1:NSTimeInterval = 0;
        var name:String = "avatar\(imgNumber).png"
        imgView!.alpha = 0.4
        imgView!.image = UIImage(named:name);
        
        //code to animate bg with delay 2 and after completion it recursively calling animateImage method
        UIView.animateWithDuration(2.0, delay: 0, options:UIViewAnimationOptions.CurveEaseOut, animations: {() in
            self.imgView!.alpha = 1.0;
            },
            completion: {(Bool) in
                imgNumber++;
                if imgNumber>4  //only for 4 image
                {
                    imgNumber = 1
                }
                self.animateImage(imgNumber);
        })
    }
    */
    struct wrap {
        static let left = UIImage(named: "triangle<")
        static let right = UIImage(named: "triangle>")
    }
}
