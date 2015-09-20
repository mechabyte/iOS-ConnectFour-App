//
//  PieceController.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/13/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import UIKit
import SwiftColor

class Piece: UIView {

    //var owner = RLMPlayer()
    var owner = Int()
    var pieceColor = Color(hexString: "#ffffff").CGColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    convenience init(frame: CGRect, pieceColor: NSString, owner: Int) {
        self.init(frame: frame)
        self.pieceColor = Color(hexString: pieceColor as String).CGColor
        self.owner = owner
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,0)
        CGContextSetFillColorWithColor(context, self.pieceColor)
        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        CGContextDrawPath(context, .FillStroke);
    }
    
    /*
    
    func declareOwner(player: RLMPlayer) {
        self.owner = player
    }

    */
    
    func declareOwner(player: Int) {
        self.owner = player
    }
    
}