//
//  Board.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/14/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation

class BoardColumn: UIView {
    
    var owner = RLMPlayer()
    var squareEdge = Float
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, squareEdge: Float) {
        self.init(frame: frame)
        self.squareEdge = squareEdge
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,0)
        CGContextSetFillColorWithColor(context, self.pieceColor.CGColor)
        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        CGContextDrawPath(context, .FillStroke);
    }
    
    func declareOwner(player: RLMPlayer) {
        self.owner = player
    }
    
}