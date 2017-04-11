//
//  ViewController.swift
//  FishGame
//
//  Created by Quang Bach on 4/3/17.
//  Copyright © 2017 QuangBach. All rights reserved.
//

import UIKit


@objc
class ViewController: UIViewController {

    var gameManager: GameManager?
    
    
    
    let background: UIImageView = {
       let imageView = UIImageView()
       imageView.image = UIImage(named: "underOcean")
       imageView.contentMode = .scaleAspectFill
       return imageView
    }()
    
    let fish: FishView = {
        let fish = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
        fish.contentMode = .scaleAspectFill
        return fish
    }()
    
    let resetBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame.size = CGSize(width: 60, height: 20)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(reset), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let addFish: UIButton = {
        let button = UIButton()
        button.setTitle("Add Fish", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame.size = CGSize(width: 60, height: 20)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addToFish), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        
        
        
        view.addSubview(background)
        view.addSubview(fish)
        view.addSubview(resetBtn)
        view.addSubview(addFish)
        //autolayout background
        view.addConstrainsWithFormat(format: "H:|[v0]|", view: background)
        view.addConstrainsWithFormat(format: "V:|[v0]|", view: background)
        
        //autolayout resetButton
        view.addConstrainsWithFormat(format: "H:[v0]-20-|", view: resetBtn)
        view.addConstrainsWithFormat(format: "V:[v0]-20-|", view: resetBtn)
        //autolayout addFish
        view.addConstrainsWithFormat(format: "H:|-20-[v0]", view: addFish)
        view.addConstrainsWithFormat(format: "V:[v0]-20-|", view: addFish)
        gameManager = GameManager()
        view.addSubview((self.gameManager?.hookView)!)
        gameManager?.fishAddToViewController(viewController: self, width: Int(self.view.bounds.width))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:))))
        Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: #selector(self.gameManager?.updateMove), userInfo: nil, repeats: true)
        
        
        
        fish.genericFish(width: Int(self.view.bounds.width))
        background.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func tapHandle(_ sender: UITapGestureRecognizer){
        let point = sender.location(in: self.view)
        self.gameManager?.dropHookAtX(x: Int(point.x))
    }
    
    
    
    func reset(){
        print("click reset")
        self.gameManager?.fishViews?.removeAllObjects()
        
        for object in self.view.subviews {
            if object.isKind(of: FishView.self) {
                object.removeFromSuperview()
            }
        }
        
        self.gameManager?.fishAddToViewController(viewController: self, width: Int(self.view.bounds.width))
        
        
    }
    
    func addToFish(){
        print("click addFish")
        self.gameManager?.fishAddToViewController(viewController: self, width: Int(self.view.bounds.width))
        
    }
    

}


// add layout Constrains
extension UIView {
    func addConstrainsWithFormat(format: String, view: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in view.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}



