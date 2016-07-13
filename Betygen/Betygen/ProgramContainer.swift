//
//  programContainer.swift
//  Betygen
//
//  Created by Linus Löfgren on 2016-07-13.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import UIKit

class programContainer {
    var view = UIView()
    var program = Prog()
    func updateView(){
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
        if self.view.superview != nil{
            self.view.frame.size.width = (self.view.superview?.frame.width)!
            self.view.frame.size.height = (self.view.superview?.frame.height)!/9
        }
        else{
            self.view.frame.size = CGSize(width: 100.0, height: 100.0)
        }
        let programNamn = program.program
        let skolNamn = program.namn
        
        
        let namnLabel = UILabel()
        namnLabel.text = skolNamn + " : " + programNamn
        namnLabel.sizeToFit()
        
        
        let poängLabel = UILabel()
        if let poäng = program.antSlut{
            poängLabel.text = String(poäng)
        }
        else{
            poängLabel.text = "0.0"
        }
        poängLabel.sizeToFit()
        
        if(namnLabel.frame.width > self.view.frame.width-poängLabel.frame.width-20.0){
            namnLabel.frame.size.width = self.view.frame.width-poängLabel.frame.width-20.0
        }
        
        namnLabel.frame.origin = CGPoint(x: 10.0, y: self.view.frame.height/2-namnLabel.frame.height/2)
        poängLabel.frame.origin = CGPoint(x: self.view.frame.width-poängLabel.frame.width-10.0, y: self.view.frame.height/2-poängLabel.frame.height/2)
        
        self.view.addSubview(namnLabel)
        self.view.addSubview(poängLabel)
    }
}
