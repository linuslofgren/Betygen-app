//
//  Kommun.swift
//  Betygen
//
//  Created by Linus Löfgren on 2016-07-13.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import Foundation

class kommun{
    var namn = ""
    var program: [Prog] = []
    func addProg(_ progr: Prog){
        program.append(progr)
    }
    init(namn: String){
        self.namn = namn
    }
}
