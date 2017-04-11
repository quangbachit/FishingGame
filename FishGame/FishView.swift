//
//  FishView.swift
//  FishGame
//
//  Created by Quang Bach on 4/3/17.
//  Copyright © 2017 QuangBach. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    
    var status: Int?
    var speed: Int?
    var vy: Int?
    var widthFrame: Int?
    var hieght: Int?
    var widthFish: Int?
    var hieghtFish: Int?
    let MOVING: Int = 0
    let CAUGHT: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.widthFish = Int(self.frame.width)
        self.hieghtFish = Int(self.frame.height)
        self.contentMode = .scaleAspectFit
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func genericFish(width: Int){
        
        
        
        self.widthFrame = width //
        vy = Int(arc4random_uniform(2)) - 1
        let y: Float = Float(arc4random_uniform(240)) + 80
        self.status = MOVING
        self.speed = Int(arc4random_uniform(5)) + 2
        
        
        if Int(self.center.x) <= -Int(self.widthFish!/2) {
            
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: "fish1")
            self.frame = CGRect(x: -CGFloat(widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.hieghtFish!))
            
        } else {
            
            self.transform = CGAffineTransform.identity
            self.image = UIImage(cgImage: (UIImage(named: "fish1")?.cgImage)!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
            self.frame = CGRect(x: CGFloat(self.widthFrame! + self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.hieghtFish!))
            self.speed = -Int(self.speed!)
        }     
        
    }
    
    func updateMoving() {
        if (status == MOVING) {
            center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(self.vy!))
            
            if Int(self.center.y) < self.widthFish! || Int(self.center.y) > self.widthFrame! {
                vy = -vy!
            }
            
            if Int(self.center.x) > self.widthFrame! && speed! > 0 || Int(self.center.x) < self.widthFish! && speed! < 0 {
                genericFish(width: self.widthFrame!)
            }
            
        } else if status == CAUGHT {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            if Int(self.center.y) < self.widthFish! {
                self.genericFish(width: self.widthFrame!)
            }
        }
    }
    
    func caught(){
        if status == MOVING {
            self.status = CAUGHT
            if speed! > 0 {
                self.transform = CGAffineTransform(rotationAngle: -.pi/2)
            } else {
                 self.transform = CGAffineTransform(rotationAngle: .pi/2)
            }
            
        }
    }
    
    
    
    
    
}
