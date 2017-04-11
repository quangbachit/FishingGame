//
//  GameManager.swift
//  FishGame
//
//  Created by Quang Bach on 4/3/17.
//  Copyright © 2017 QuangBach. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    var fishViews: NSMutableArray?
    var hookView: HookerView?
    
    override init() {
        self.fishViews = NSMutableArray()
        self.hookView = HookerView(frame: CGRect(x: 0, y: -490, width: 20, height: 490))
    }
    
    func fishAddToViewController(viewController: UIViewController, width: Int){
        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
        fishView.genericFish(width: width)
        self.fishViews?.add(fishView)
        viewController.view.addSubview(fishView)
        
    }
    
    func bite(fishView: FishView) {
        if fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP {
            fishView.caught()
            fishView.center = CGPoint(x: self.hookView!.center.x, y: self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTF
        }
    }
    func updateMove(){
        self.hookView?.updateHook()
        for fishView in fishViews! {
            let fish: FishView = fishView as! FishView
            fish.updateMoving()
            if fish.frame.contains(CGPoint(x: self.hookView!.center.x, y: self.hookView!.frame.origin.y + self.hookView!.frame.height + fish.frame.width/2)) {
                bite(fishView: fishView as! FishView)
            }
        }
    }
    
    func dropHookAtX(x: Int){
        self.hookView?.dropDownAtX(x: x)
    }
    
    
}
