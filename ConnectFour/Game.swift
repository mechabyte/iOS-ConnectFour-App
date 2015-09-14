//
//  Game.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/13/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation

class Game {
    
    let numColumns = 7
    let numRows = 6
    var board = Array<Array<Piece>>()
    let view = UIView
    var gutterW, gutterH
    
    init(view: UIView) {
        self.view = view
        var squareEdge
        print("It's time to play a game!")
        if ( (view.frame.size.height / 6) <= (view.frame.size.width / 7) ) {
            self.colWidth = (view.frame.size.height / 6)
            self.rowHeight = (view.frame.size.height / 6)
            squareEdge = (view.frame.size.width - (self.colWidth * 7) / 2)
        } else {
            self.colwidth = (view.frame.size.width / 7)
            self.rowHeight = (view.frame.size.width / 7)
            squareEdge = (view.frame.size.height - (self.rowHeight * 6) / 2)
        }
    }
    
    public func drawBoard() {
        let context = UIGraphicsGetCurrentContext()
        /* Calculate board dimensions */
        
    }
    
    
}
