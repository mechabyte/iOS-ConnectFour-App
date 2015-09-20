//
//  Game.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/13/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import Foundation
import pop
import UIKit
import SwiftColor

class Game {
    /*
     * Game init
     */
    let numColumns = 7
    let numRows = 6
    var board = Array<Array<Piece>>()
    var gutterX,gutterY,squareEdge: CGFloat!
    
    let players = [1,2]
    
    let screenHeight = UIScreen.mainScreen().bounds.height
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    var turn: Int = 1
    
    let view: UIView!
    
    init(view: UIView) {
        self.view = view
        self.calculateGutters()
        self.drawBoard()
        self.setupLogic()
    }
    
    func calculateGutters() -> Void {
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
        if( (screenHeight/6) < (screenWidth/7) ) {
            /* Restricted on height, add gutter to horizontal layout */
            self.squareEdge = (screenHeight/6)
            self.gutterX = CGFloat( (screenWidth - ( CGFloat(7) * ( CGFloat(self.squareEdge!) + 2.0) )) / 2 )
            self.gutterY = CGFloat(0)
        } else {
            /* Restricted on width, add gutter to vertical layout */
            self.squareEdge = (screenWidth/7)
            self.gutterX = CGFloat(0)
            self.gutterY = CGFloat( ( screenHeight - ( CGFloat(6) * ( CGFloat(self.squareEdge!) + 2.0) )) / 2 )
        }
    }
    
    func horizontalRecursionCount(rowIndex:Int, colIndex:Int, depth:Int, direction:String, xTravel:Int) -> Int {
        let reachedLeft:Bool = (colIndex == 0)
        let reachedRight:Bool = ((colIndex+1) == self.numColumns)
        switch direction {
            case "left":
                if (reachedLeft) {
                    return depth
                } else {
                    let nextColumnPiecesCount = self.board[colIndex-1].count
                    let requiredPiecesCount = (self.board[colIndex + xTravel].count)
                    if (nextColumnPiecesCount >= requiredPiecesCount) {
                        if (self.board[colIndex-1][rowIndex].owner == self.board[colIndex][rowIndex].owner) {
                            return self.horizontalRecursionCount(rowIndex, colIndex: (colIndex-1), depth: (depth+1), direction: "left", xTravel: (xTravel+1))
                        } else {
                            return depth
                        }
                    } else {
                        return depth
                    }
                }
            //case "right":
            default:
                if (reachedRight) {
                    return depth
                } else {
                    let nextColumnPiecesCount = self.board[colIndex+1].count
                    let requiredPiecesCount = (self.board[colIndex - xTravel].count)
                    if (nextColumnPiecesCount >= requiredPiecesCount) {
                        if (self.board[colIndex+1][rowIndex].owner == self.board[colIndex][rowIndex].owner) {
                            return self.horizontalRecursionCount(rowIndex, colIndex: (colIndex+1), depth: (depth+1), direction: "right", xTravel: (xTravel+1))
                        } else {
                            return depth
                        }
                    } else {
                        return depth
                    }
            }
        }
    }
    
    func verticalRecursionCount(rowIndex:Int, colIndex:Int, depth:Int) -> Int {
        if (rowIndex == 0) {
            return depth
        } else {
            if (self.board[colIndex][rowIndex-1].owner == self.board[colIndex][rowIndex].owner) {
                return self.verticalRecursionCount((rowIndex-1), colIndex: colIndex, depth: (depth+1))
            } else {
                return depth
            }
        }
    }
    
    func diagonalRecursionCount(rowIndex:Int, colIndex:Int, depth:Int, direction:String, xTravel:Int, yTravel:Int) -> Int {
        let reachedTop:Bool = ((rowIndex+1) == self.numRows)
        let reachedRight:Bool = ((colIndex+1) == self.numColumns)
        let reachedBottom:Bool = (rowIndex == 0)
        let reachedLeft:Bool = (colIndex == 0)
        
        switch direction {
            case "bottomLeft":
                if (reachedBottom || reachedLeft) {
                    return depth
                } else {
                    let nextColumnPiecesCount = self.board[colIndex-1].count
                    let requiredPiecesCount = (self.board[colIndex + xTravel].count - yTravel)
                    if (nextColumnPiecesCount >= requiredPiecesCount) {
                        if (self.board[colIndex-1][rowIndex-1].owner == self.board[colIndex][rowIndex].owner) {
                            return self.diagonalRecursionCount((rowIndex-1), colIndex: (colIndex-1), depth: (depth+1), direction: "bottomLeft", xTravel: (xTravel+1), yTravel: (yTravel+1))
                        } else {
                            return depth
                        }
                    } else {
                        return depth
                    }
                }
            
            case "bottomRight":
                if (reachedBottom || reachedRight) {
                    return depth
                } else {
                    let nextColumnPiecesCount = self.board[colIndex+1].count
                    let requiredPiecesCount = (self.board[colIndex - xTravel].count - yTravel)
                    if (nextColumnPiecesCount >= requiredPiecesCount) {
                        if (self.board[colIndex+1][rowIndex-1].owner == self.board[colIndex][rowIndex].owner) {
                            return self.diagonalRecursionCount((rowIndex-1), colIndex: (colIndex+1), depth: (depth+1), direction: "bottomRight", xTravel: (xTravel+1), yTravel: (yTravel+1))
                        } else {
                            return depth
                        }
                    } else {
                        return depth
                    }
                }
            
            case "topRight":
                if (reachedTop || reachedRight) {
                    return depth
                } else {
                    let nextColumnPiecesCount = self.board[colIndex+1].count
                    let requiredPiecesCount = (self.board[colIndex - xTravel].count + yTravel)
                    if (nextColumnPiecesCount > requiredPiecesCount) {
                        if (self.board[colIndex+1][rowIndex+1].owner == self.board[colIndex][rowIndex].owner) {
                            return self.diagonalRecursionCount((rowIndex+1), colIndex: (colIndex+1), depth: (depth+1), direction: "topRight", xTravel: (xTravel+1), yTravel: (yTravel+1))
                        } else {
                            return depth
                        }
                    } else {
                        
                        return depth
                    }
                }
            
            //case "topLeft":
            default:
                if (reachedTop || reachedLeft) {
                    return depth
                } else {
                    let nextColumnPiecesCount = self.board[colIndex-1].count
                    let requiredPiecesCount = (self.board[colIndex + xTravel].count + yTravel)
                    if (nextColumnPiecesCount > requiredPiecesCount) {
                        if (self.board[colIndex-1][rowIndex+1].owner == self.board[colIndex][rowIndex].owner) {
                            return self.diagonalRecursionCount((rowIndex+1), colIndex: (colIndex-1), depth: (depth+1), direction: "topLeft", xTravel: (xTravel+1), yTravel: (yTravel+1))
                        } else {
                            return depth
                        }
                    } else {
                        return depth
                    }
                }
        }
    }
    
    func wonDiag(rowIndex:Int, colIndex:Int) -> Bool {
        let bottomLeft = self.diagonalRecursionCount(rowIndex, colIndex: colIndex, depth: 0, direction: "bottomLeft", xTravel: 0, yTravel: 1)
        let topRight = self.diagonalRecursionCount(rowIndex, colIndex: colIndex, depth: 0, direction: "topRight", xTravel: 0, yTravel: 0)
        let topLeft = self.diagonalRecursionCount(rowIndex, colIndex: colIndex, depth: 0, direction: "topLeft", xTravel: 0, yTravel: 0)
        let bottomRight = self.diagonalRecursionCount(rowIndex, colIndex: colIndex, depth: 0, direction: "bottomRight", xTravel: 0, yTravel: 1)
        if ( ((topLeft + bottomRight + 1) == 4) || ((bottomLeft + topRight + 1) == 4) ) {
            return true
        } else {
            return false
        }
    }
    
    func wonHor(rowIndex:Int, colIndex:Int) -> Bool {
        let left:Int = self.horizontalRecursionCount(rowIndex, colIndex: colIndex, depth: 0, direction: "left", xTravel: 0)
        let right:Int = self.horizontalRecursionCount(rowIndex, colIndex: colIndex, depth: 0, direction: "right", xTravel: 0)
        if ( (left + right + 1) == 4) {
            return true
        } else {
            return false
        }
    }
    
    func wonVert(rowIndex:Int, colIndex:Int) -> Bool {
        if ( (self.verticalRecursionCount(rowIndex, colIndex: colIndex, depth: 0) + 1) == 4) {
            return true
        } else {
            return false
        }
    }
    
    func previousMoveWasWinning(column:Int, row: Int) -> Bool {
        let wonDiagnolly = self.wonDiag((row-1), colIndex: (column-1))
        let wonHorizontally = self.wonHor((row-1), colIndex: (column-1))
        let wonVertically = self.wonVert((row-1), colIndex: (column-1))
        if (wonDiagnolly || wonHorizontally || wonVertically) {
            return true
        } else {
            return false
        }
    }
    
    func placePiece(point: CGPoint!) -> Void {
        // Find out where we should place the piece
        let column = self.columnForTap(point)
        let row = self.rowForTap(column)
        let boardPosition = self.coordinatesForPiece(column)
        
        // Make sure the user tapped inside the board
        if ((boardPosition.x >= 0) && (boardPosition.y > 0)) {
            let pieceDiameter = self.squareEdge
            // Create a new piece that we will animate
            let piece = Piece(frame: CGRectMake(boardPosition.x, -pieceDiameter, pieceDiameter, pieceDiameter), pieceColor: (self.turn % 2 == 0) ? "#EDD568" : "#C24040", owner: (self.turn % 2 == 0) ? 2 : 1)
            self.storePiece(column, piece: piece)
            
            self.previousMoveWasWinning(column, row: row)
            
            // Add piece to the view
            self.view.insertSubview(piece, atIndex: (2000-self.turn))
            // Increment turn for player move tracking
            // Animate piece to bottom of board
            let translate = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
            translate.toValue = boardPosition.y
            translate.springBounciness = 1.5
            translate.springSpeed = CGFloat(1)
            translate.velocity = NSNumber(int: 3)
            piece.layer.pop_addAnimation(translate, forKey: "dropPiece")
            
            /*
            for columnArrayIndex in 0...(self.numColumns - 1) {
                if ((self.board[columnArrayIndex].count > 0) && ((columnArrayIndex + 1) == column)) {
                    for rowArrayIndex in 0...self.board[columnArrayIndex].count {
                        if ( (rowArrayIndex + 1) == self.board[columnArrayIndex].count ) {
                            // print("Placed piece in column \(columnArrayIndex + 1) row \(rowArrayIndex + 1)")
                        }
                    }
                }
            }
            */
            
            self.turn++
        }
        
        
    }
    
    func columnForTap(tap: CGPoint!) -> Int {
        switch (tap.x - self.gutterX - (self.squareEdge * 0.25)){
        case 0..<(1 * self.squareEdge):
            return 1
        case (1 * self.squareEdge)..<(2 * self.squareEdge):
            return 2
        case (2 * self.squareEdge)..<(3 * self.squareEdge):
            return 3
        case (3 * self.squareEdge)..<(4 * self.squareEdge):
            return 4
        case (4 * self.squareEdge)..<(5 * self.squareEdge):
            return 5
        case (5 * self.squareEdge)..<(6 * self.squareEdge):
            return 6
        case (6 * self.squareEdge)..<(7 * self.squareEdge):
            return 7
        default:
            return 0
        }
    }
    
    func rowForTap(column: Int) -> Int {
        if (column>0) {
            return (self.board[column - 1].count + 1)
        } else {
            return 0
        }
    }
    
    func coordinatesForPiece(column: Int!) -> CGPoint {
        var coordinates = CGPoint()
        if (column > 0) {
            coordinates.x = (self.gutterX + (CGFloat(column - 1) * self.squareEdge) + (self.squareEdge * 0.25))
            coordinates.y = self.screenHeight - ( CGFloat(self.board[column - 1].count) * self.squareEdge)
        }
        return coordinates
    }
    
    func storePiece(column: Int, piece: Piece) -> Void {
        self.board[column - 1].append(piece)
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
                
                boardSquare.layer.borderColor = Color(hexString: "#22558C").CGColor
                
                self.view.insertSubview(boardSquare, atIndex: counter )
                counter++
            }
        }
    }
    
    func setupLogic() -> Void {
        for column in 1...self.numColumns {
           self.board.insert( Array<Piece>(), atIndex: (column-1))
        }
    }
    
    
}
