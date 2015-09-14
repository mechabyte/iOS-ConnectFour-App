//
//  PieceController.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/13/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import UIKit

class Piece: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var owner = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,1)
        
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        
        UIColor.redColor().set()
        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        
        CGContextDrawPath(context, .FillStroke);
        
        
    }
    
}
