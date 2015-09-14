//
//  Board.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/14/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation
import UIKit

class Board {
    init() {
    }
}

class BoardSquare: UIView {
    
    var color = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        print("Draw that bitch")
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,2.0)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        UIColor.blueColor().set()
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
    }
    
    /*
    
    CGContextMoveToPoint(context, 100, 100)
    CGContextAddLineToPoint(context, 150, 150)
    CGContextAddLineToPoint(context, 100, 200)
    CGContextAddLineToPoint(context, 50, 150)
    CGContextAddLineToPoint(context, 100, 100)
    CGContextStrokePath(context)
    
    
    ------------
    
    - (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0f);
    
    CGContextMoveToPoint(context, 0.0f, 0.0f); //start at this point
    
    CGContextAddLineToPoint(context, 20.0f, 20.0f); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
    }
    
    */
    
}