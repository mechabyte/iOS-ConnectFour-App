//
//  ViewController.swift
//  ConnectFour
//
//  Created by Matthew Smith on 9/13/15.
//  Copyright © 2015 Matthew Smith. All rights reserved.
//

import UIKit
import pop
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var board: UIView!
    
    var game: Game!
    var turn = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game = Game(view: board)
        self.game.drawBoard()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
       // UIDevice.currentDevice().setValue(leftRotation, forKey: "orientation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var counter:Int = 2000
        if let touch = touches as? Set<UITouch> {
            /* Define piece properties and initialize */
            let circleCenter = touch.first!.locationInView(view)
            let pieceWidth = self.game.squareEdge
            let circleWidth = pieceWidth
            let circleHeight = circleWidth
            let piece = Piece(frame: CGRectMake(circleCenter.x - (circleWidth/2), -circleHeight, circleWidth, circleHeight), pieceColor: (self.turn % 2 == 0) ? UIColor.yellowColor() : UIColor.redColor())
            /* Increase turns */
            self.turn++
            /* Add piece view to superview */
            board.insertSubview(piece, atIndex: counter)
            /* Animate bounce into board */
            let translate = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
            translate.toValue = circleCenter.y + (circleHeight/2)
            translate.springBounciness = 3.0
            translate.springSpeed = CGFloat(1)
            translate.velocity = NSNumber(int: 3)
            piece.layer.pop_addAnimation(translate, forKey: "dropPiece")
            counter--
        }
    }

}

