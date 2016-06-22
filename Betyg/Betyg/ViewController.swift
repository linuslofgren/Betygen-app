//
//  ViewController.swift
//  Betyg
//
//  Created by Linus Löfgren on 2016-06-17.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...17 {
            let selec = UISegmentedControl(items: ["-", "E", "D", "C", "B", "A"])
            selec.frame.origin.x = view.frame.size.width/2 - selec.frame.size.width/2
            selec.frame.origin.y = CGFloat(50*i+100)
            selec.selectedSegmentIndex = 0
            view.addSubview(selec)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

