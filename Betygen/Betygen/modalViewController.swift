//
//  modalViewController.swift
//  Betyg
//
//  Created by Linus Löfgren on 2016-07-01.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import UIKit


class modalViewController: UIViewController, UIScrollViewDelegate {
    
    var animations: [UIScrollView] = []
    
    var pr: Prog?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white()
        let btn = UIButton()
        btn.setTitleColor(UIColor.black(), for: [])
        btn.setTitle("Stäng", for: [])
        btn.sizeToFit()
        btn.frame.origin.x = view.frame.width-btn.frame.width-5.0
        btn.frame.origin.y = 15.0
        btn.addTarget(self, action: #selector(btnPress), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        
        
        if(pr != nil){
            let str = (pr?.program)!
            let title = UILabel()
            title.text = pr?.namn
            title.font = UIFont(name: (title.font?.fontName)!, size: 25.0)
            title.sizeToFit()
            title.frame.origin = CGPoint(x: view.frame.width/2-title.frame.width/2, y: view.frame.height/10)
            view.addSubview(title)
            let programText = UILabel()
            programText.text = "Program:"
            programText.font = UIFont(name: (programText.font?.fontName)!, size: 15.0)
            programText.sizeToFit()
            programText.frame.origin = CGPoint(x: 10.0, y: view.frame.height/5)
            view.addSubview(programText)
            
            let textScroll = makeScroll(la: programText, txt: str)
            
            view.addSubview(textScroll)
            
            
            let medSlut = pr?.medSlut
            let medPrel = pr?.medPrel
            let medRes = pr?.medRes
            let antSlut = pr?.antSlut
            let antPrel = pr?.antPrel
            let antRes = pr?.antRes
            
            
            
            let h = textScroll.frame.origin.y+textScroll.frame.height
            
            for (i, _) in ["antSlut", "antPrel", "antRes", "medSlut", "medPrel", "medRes"].enumerated() {
                var txt = ""
                var rightTxt = ""
                switch i {
                case 0:
                    if medSlut != nil{
                        txt = "Medelpoäng slutantagning : "
                        rightTxt = get(medSlut!)
                    }
                case 1:
                    if medPrel != nil{
                        txt = "Medelpoäng preliminärantagning : "
                        rightTxt = get(medPrel!)
                    }
                case 2:
                    if medRes != nil{
                        txt = "Medelpoäng reservntagning : "
                        rightTxt = get(medRes!)
                    }
                case 3:
                    if antSlut != nil{
                        txt = "Slutantagning : "
                        rightTxt = get(antSlut!)
                    }
                case 4:
                    if antPrel != nil{
                        txt = "Preliminärantagning : "
                        rightTxt = get(antPrel!)
                    }
                case 5:
                    if antRes != nil{
                        txt = "Reservntagning : "
                        rightTxt = get(antRes!)
                    }
                default:
                    txt = "----- : "
                    rightTxt = "--- poäng"
                }
                
                
                let poänglabel = UILabel()
                poänglabel.text = txt
                poänglabel.sizeToFit()
                poänglabel.frame.origin = CGPoint(x: 20.0, y: h + 20.0 + (poänglabel.frame.height+5.0)*CGFloat(i))
                view.addSubview(poänglabel)
                let sc = makeScroll(la: poänglabel, txt: rightTxt)
                view.addSubview(sc)
            }
        }
        else{
            return
        }
        
        //view.addSubview(l)
        
        
    }
    
    func get(_ nu: Float) -> String{
        if(nu > -1.0){
            return String(nu) + " poäng"
        }
        else{
            switch nu {
            case -1.0:
                return "Alla behöriga antagna"
            case -2.0:
                return "Enbart test"
            case -3.0:
                return "Det finns ingen behörig sökande"
            case -4.0:
                return "Ingen preliminärintagning görs"
            case -5.0:
                return "Mottagande skola gör antagningen"
            default:
                return "--"
            }
        }
    }
    
    func makeScroll(la: UILabel, txt: String)-> UIScrollView{
        let l = UILabel()
        l.text = txt
        l.font = UIFont(name: (l.font?.fontName)!, size: (la.font?.pointSize)!)
        l.sizeToFit()
        l.frame.origin = CGPoint(x: 0.0, y: 0.0)
        let textScroll = UIScrollView()
        textScroll.frame.origin = CGPoint(x: la.frame.width+la.frame.origin.x+5.0, y: la.frame.origin.y)
        textScroll.frame.size = CGSize(width: view.frame.width-textScroll.frame.origin.x-10.0, height: l.frame.height)
        
        textScroll.contentSize = CGSize(width: l.frame.width, height: textScroll.frame.height)
        textScroll.addSubview(l)
        textScroll.delegate = self
        if(textScroll.contentSize.width>textScroll.frame.width){
            textScroll.contentOffset = CGPoint(x: -10.0, y: 0)
        }
        
        animations.append(textScroll)
        return textScroll
    }
    

    
    func startAnim(){
        for scroll in animations {
            if(scroll.contentSize.width>scroll.frame.width){
                UIView.animate(withDuration: Double(scroll.contentSize.width+20.0)*0.01, delay: 1.0, options: [UIViewAnimationOptions.repeat,  UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.curveLinear], animations: {
                    scroll.contentOffset = CGPoint(x: scroll.contentSize.width-scroll.frame.width+10.0, y: 0)
                    }, completion: {finish in
                        scroll.contentOffset = CGPoint(x: -10.0, y: 0.0)
                })
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAnim()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        return
    }
    
    func btnPress(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
