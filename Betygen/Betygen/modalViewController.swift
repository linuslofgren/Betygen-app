//
//  modalViewController.swift
//  Betyg
//
//  Created by Linus Löfgren on 2016-07-01.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import UIKit


class modalViewController: UIViewController {
    var pr: prog?
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white()
        let btn = UIButton()
        btn.setTitleColor(UIColor.black(), for: [])
        btn.setTitle("CLOSE", for: [])
        btn.sizeToFit()
        btn.frame.origin.x = view.frame.width-btn.frame.width-5.0
        btn.frame.origin.y = 15.0
        btn.addTarget(self, action: #selector(btnPress), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        
        let l = UILabel()
        if(pr != nil){
            
            if let a = pr?.program{
                l.text = "\(a)"
            }
            else{
                l.text = "Ingen info..."
            }
            
        }
        else{
            l.text = "Ingen info..."
        }
        l.sizeToFit()
        l.frame.origin = CGPoint(x: view.frame.width/2-l.frame.width/2, y: 100.0)
        view.addSubview(l)
    }
    
    func btnPress(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
