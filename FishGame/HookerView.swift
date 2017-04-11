//
//  HookerView.swift
//  FishGame
//
//  Created by Quang Bach on 4/3/17.
//  Copyright © 2017 QuangBach. All rights reserved.
//

import UIKit

class HookerView: UIImageView {
    
    let PREPARE = 0
    let DROPPING = 1
    let DRAWINGUP = 2
    let CAUGHTF = 3
    
    var status: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "hook")
        self.status = PREPARE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHook(){
        if status == DROPPING {
            
            self.center = CGPoint(x: self.center.x, y: self.center.y + 10)
            
            if self.frame.origin.y + self.frame.height > 480 {
                self.status = DRAWINGUP
            }
            
            
        } else if status == DRAWINGUP {
            
            self.center = CGPoint(x: self.center.x, y: self.center.y - 20)
            
            if self.frame.origin.y + self.frame.height < 0 {
                self.status = CAUGHTF
            }
            
            
            
        } else if status == CAUGHTF {
            
            
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            
            if self.frame.origin.y + self.frame.height < 0 {
                self.status = PREPARE
            }
            
        }
    }
    
    func dropDownAtX(x: Int){
        if status == PREPARE {
            self.center = CGPoint(x: CGFloat(x), y: self.center.y)
            status = DROPPING
        }
    }
    
}
