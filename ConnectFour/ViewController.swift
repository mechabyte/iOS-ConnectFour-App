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
import SwiftColor

class ViewController: UIViewController {
    
    @IBOutlet weak var board: UIView!
    
    var game: Game!
    var turn = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game = Game(view: board)        
    }
    
    override func viewDidAppear(animated: Bool) {
       // UIDevice.currentDevice().setValue(leftRotation, forKey: "orientation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent? ) {
        if let touch = touches as? Set<UITouch> {
            self.game.placePiece( touch.first!.locationInView(view) )
        }
    }

}

