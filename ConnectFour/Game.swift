//
//  Game.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/13/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation
import UIKit

class Game {
    
    let numColumns = 7
    let numRows = 6
    
    var board = Array<Array<Piece>>()
    var gutterX,gutterY,squareEdge: CGFloat!
    
    let screenHeight = UIScreen.mainScreen().bounds.height
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    let view: UIView!
    
    /*
    init(view: UIView) {
        self.view = view
        var gutterX, gutterY: CGFloat?
        var squareEdge: CGFloat!
        let screenSize = UIScreen.mainScreen().bounds
        
        if ( (screenSize.height / 6) < (screenSize.width / 7 ) ) {
            /* More restricted by height, adjusted square dimensions so that they fit */
            squareEdge = (screenSize.height / 6)
            gutterY = CGFloat(0)
            gutterX = CGFloat( (screenSize.height - ( CGFloat(self.numRows) * squareEdge )) / 2 )
        } else {
            squareEdge = (screenSize.width / 7)
            gutterY = CGFloat( (screenSize.width - ( CGFloat(self.numColumns) * squareEdge )) / 2 )
            gutterX = CGFloat(0)
        }
        
        print("Screen size (horizontal) is: \(screenSize.width)")
        print("Screen size (vertical) is: \(screenSize.height)")
        print("Square edge length is: \(squareEdge)")
        print("Gutter width (horizontal) is: \( gutterX )")
        print("Gutter width (vertical) is: \( gutterY )")
        self.drawBoard(squareEdge, gutterX: gutterX, gutterY: gutterY)
    } */
    
    init(view: UIView) {
        self.view = view
        
        if( (self.screenHeight/6) < (self.screenWidth/7) ) {
            /* Restricted on height, add gutter to horizontal layout */
            self.squareEdge = (self.screenHeight/6)
            self.gutterY = CGFloat(0)
            self.gutterX = CGFloat( (self.screenWidth - ( CGFloat(self.numColumns) * (self.squareEdge + 2.0) )) / 2 )
        } else {
            /* Restricted on width, add gutter to vertical layout */
            self.squareEdge = (self.screenWidth/7)
            self.gutterY = CGFloat( (self.screenHeight - ( CGFloat(self.numRows) * (self.squareEdge + 2.0) )) / 2 )
            self.gutterX = CGFloat(0)
        }
        
        print("Screen size (horizontal) is: \(self.screenWidth)")
        print("Screen size (vertical) is: \(self.screenHeight)")
        print("Square edge length is: \(self.squareEdge)")
        print("Gutter width (horizontal) is: \( self.gutterX )")
        print("Gutter width (vertical) is: \( self.gutterY )")
    }
    
    func drawBoard() {
        var counter: Int = 500
        for indexX in 1...self.numColumns {
            for indexY in 1...self.numRows {
                
                let column = CGFloat(indexX)
                let row = CGFloat(indexY)
                
                let halfSquare = (self.squareEdge/2)
                let tlX = (self.gutterX + (column*self.squareEdge) - self.squareEdge + (halfSquare/2))
                let tlY = (self.gutterY + (row*self.squareEdge) - self.squareEdge)
                
                let boardSquare = UIView(frame: CGRectMake(tlX,tlY, self.squareEdge, self.squareEdge))
                boardSquare.clipsToBounds = false
                boardSquare.layer.masksToBounds = false
                boardSquare.layer.backgroundColor = UIColor.clearColor().CGColor
                boardSquare.layer.borderWidth = 4.0
                
                boardSquare.layer.borderColor = UIColor.init(red: CGFloat(34/255), green: CGFloat(85/255), blue: CGFloat(140/255), alpha: CGFloat(1)).CGColor
                
                self.view.insertSubview(boardSquare, atIndex: counter )
                counter++
            }
        }
    }
    
    
}
