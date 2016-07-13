//
//  Program.swift
//  Betygen
//
//  Created by Linus Löfgren on 2016-07-13.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import Foundation

class Prog {
    var namn: String
    var program: String
    var antPrel: Float?
    var medPrel: Float?
    var antSlut: Float?
    var medSlut: Float?
    var antRes: Float?
    var medRes: Float?
    init(skol: String, prog: String, antPrel: Float?, medPrel: Float?, antSlut: Float?, medSlut: Float?, antRes: Float?,medRes: Float?){
        self.namn = skol
        self.program = prog
        self.antPrel = antPrel
        self.medPrel = medPrel
        self.antSlut = antSlut
        self.medSlut = medSlut
        self.antRes = antRes
        self.medRes = medRes
    }
    init(){
        self.namn = ""
        self.program = ""
    }
    subscript(prop: String) -> String{
        get{
            switch prop{
            case "skola":
                return self.namn
            case "program":
                return self.program
            default:
                return ""
            }
        }
        set(newValue){
            switch prop{
            case "namn":
                self.namn = newValue
            case "program":
                self.program = newValue
            default:
                break
            }
        }
    }
    subscript(prop: String) -> Float?{
        get{
            switch prop{
            case "antPrel":
                return self.antPrel
            case "medPrel":
                return self.medPrel
            case "antSlut":
                return self.antSlut
            case "medSlut":
                return self.medSlut
            case "antRes":
                return self.antRes
            case "medRes":
                return self.medRes
            default:
                return nil
            }
        }
        set(newValue){
            switch prop{
            case "antPrel":
                self.antPrel = newValue
            case "medPrel":
                self.medPrel = newValue
            case "antSlut":
                self.antSlut = newValue
            case "medSlut":
                self.medSlut = newValue
            case "antRes":
                self.antRes = newValue
            case "medRes":
                self.medRes = newValue
            default:
                break
            }
        }
    }
}
