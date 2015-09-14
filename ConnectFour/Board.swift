//
//  Board.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/14/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation
import UIKit

class BoardColumn: UIView {
    
    var squareEdge = Float
    var drawAt = CGPoint
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, squareEdge: Float, drawAt: CGPoint ) {
        self.init(frame: frame)
        self.squareEdge = squareEdge
        self.drawAt = drawAt
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextSetLineWidth(context,2.0)
        CGContextMoveToPoint(context, self.drawAt.x, self.drawAt.y)
        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        CGContextDrawPath(context, .FillStroke);
    }
    
    /*
    
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