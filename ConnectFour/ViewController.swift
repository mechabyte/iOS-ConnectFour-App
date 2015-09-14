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
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let touch = touches as? Set<UITouch> {
            let circleCenter = touch.first!.locationInView(view)
            let viewWidth = self.view.frame.size.width
            let viewHeight = self.view.frame.size.height
            
            
            let pieceWidth = CGFloat( ((viewWidth/7) < (viewHeight/6)) ? (viewWidth/6) : (viewHeight/7) )
            
            let circleWidth = pieceWidth
            let circleHeight = circleWidth
            
            let piece = Piece(frame: CGRectMake(circleCenter.x, circleCenter.y, circleWidth, circleHeight))
            
            view.addSubview(piece)
        }
    }

}

