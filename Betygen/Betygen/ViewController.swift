//
//  ViewController.swift
//  Betyg
//
//  Created by Linus Löfgren on 2016-06-17.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import UIKit


//TODO: schoolScrollViews
enum betyg: Double {
    case f = 0.0
    case e = 10.0
    case d = 12.5
    case c = 15.0
    case b = 17.5
    case a = 20.0
    
}

enum ämnen: String{
    case Bild
    case Biologi
    case Engelska
    case Fysik
    case Geografi
    case Hemochkonsumentkunskap
    case Historia
    case Idrott
    case Kemi
    case Matematik
    case Musik
    case Religionskunskap
    case Samhällskunskap
    case Slöjd
    case Svenska
    case Teknik
}

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

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var current: Prog?
    
    let okColor = UIColor(hue: 152/360, saturation: 54/100, brightness: 76/100, alpha: 1.0)
    
    var kommuner: [kommun] = []
    
    var segments: [UISegmentedControl] = []
    
    var cleared = 0
    
    let poängLabel = UILabel()
    
    let statView = UIView()
    let selectView = UIView()
    let schoolView = UIView()
    
    let schoolScroll = UIScrollView()
    
    var schoolScrollViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        statView.frame = view.frame
        selectView.frame = view.frame
        schoolView.frame = view.frame
        
        statView.frame.origin.x = 0.0
        selectView.frame.origin.x = view.frame.width
        schoolView.frame.origin.x = view.frame.width*2
        let mainScroll = UIScrollView()
        
        mainScroll.frame = view.frame
        mainScroll.contentSize = CGSize(width: view.frame.width*3, height: view.frame.height)
        mainScroll.isPagingEnabled = true
        mainScroll.bounces = false
        mainScroll.showsHorizontalScrollIndicator = false
        mainScroll.contentOffset.x = view.frame.width
        
        let downSpace: CGFloat = 75.0
        let mar: CGFloat = 15.0
        
        
        //statView
        
        
        statView.backgroundColor = UIColor.red()
        var grad = CAGradientLayer()
        grad.frame = statView.bounds
        grad.colors = [UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.0).cgColor as AnyObject,UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor as AnyObject]
        grad.startPoint = CGPoint(x: 0, y: 0)
        grad.endPoint = CGPoint(x: 0, y: 1)
        statView.layer.addSublayer(grad)
        
        poängLabel.text = "000.0"
        poängLabel.font = UIFont(name: (poängLabel.font?.fontName)!, size: 30.0)
        poängLabel.sizeToFit()
        poängLabel.frame.origin = CGPoint(x: statView.frame.width/2-poängLabel.frame.width/2, y: 20.0)
        statView.addSubview(poängLabel)
        
        /*var web = UIWebView()
         web.frame.size = CGSize(width: statView.frame.width, height: 700.0)
         web.frame.origin = CGPoint(x: 0, y: 50.0)
         let url = Bundle.main().urlForResource("index", withExtension: "html")
         let req = NSURLRequest(url: url!)
         web.loadRequest(req as URLRequest)
         statView.addSubview(web)*/
        
        /*
         let file = Bundle.main().pathForResource("small", ofType: "json")
         do{
         let txt = try String(contentsOfFile: file!, encoding: String.Encoding.utf8)
         json(data: txt)
         } catch {
         print("error \(error)")
         }
         
         */
        //INTERNET
        if let url = URL(string: "https://raw.githubusercontent.com/linuslofgren/Betygen/master/DATA/output.json"){
            do{
                let text = try NSString(contentsOf: url, usedEncoding: nil)
                json(text as String)
            }
            catch{
                print("\(error)")
            }
        }
        
        //SelectView
        
        let scroll = UIScrollView()
        let upperView = UIView()
        let margin: CGFloat = 15.0
        scroll.frame.origin.y = downSpace+mar
        scroll.frame.size = CGSize(width: selectView.frame.width, height: selectView.frame.height-downSpace-mar)
        upperView.frame.size = CGSize(width: view.frame.width, height: downSpace)
        upperView.frame.origin.y = mar
        let border = CALayer()
        border.frame = CGRect(x: 0.0, y: upperView.frame.height, width: upperView.frame.width, height: 1.0)
        border.backgroundColor = UIColor.black().cgColor
        //upperView.layer.addSublayer(border)
        
        let b = [ämnen.Bild, .Biologi,.Engelska,.Fysik,.Geografi,.Hemochkonsumentkunskap,.Historia,.Idrott,.Kemi,.Matematik,.Musik,.Religionskunskap,.Samhällskunskap,.Slöjd,.Svenska,.Teknik]
        
        
        
        
        
        for (i, e) in b.enumerated(){
            let la = UILabel()
            la.font = UIFont.systemFont(ofSize: 30.0)
            if(e == ämnen.Hemochkonsumentkunskap){
                la.text = "Hem- och konsumentkunskap"
            }
            else if(e == ämnen.Idrott){
                la.text = "Idrott och Hälsa"
            }
            else{
                la.text = e.rawValue
            }
            la.sizeToFit()
            la.textAlignment = .center
            la.frame.origin.x = view.frame.size.width/2 - la.frame.size.width/2
            
            let selec = UISegmentedControl(items: ["F", "E", "D", "C", "B", "A"])
            selec.frame.size = CGSize(width: selec.frame.width*2, height: selec.frame.height*2)
            let opt = NSDictionary(object: UIFont.boldSystemFont(ofSize: 30.0), forKey: NSFontAttributeName)
            selec.setTitleTextAttributes(opt as [NSObject : AnyObject], for: [])
            selec.addTarget(self, action: #selector(segCh), for: UIControlEvents.valueChanged)
            let h = CGFloat((selec.frame.height+la.frame.height+margin)*CGFloat(i))
            la.frame.origin.y = h
            
            selec.frame.origin.x = view.frame.size.width/2 - selec.frame.size.width/2
            let h1 = CGFloat(h+la.frame.height+margin/2)
            selec.frame.origin.y = h1
            //scroll.contentSize = CGSize(width: scroll.frame.width, height: CGFloat(h1+selec.frame.height+10.0))
            selec.selectedSegmentIndex = 0
            scroll.addSubview(la)
            scroll.addSubview(selec)
            segments.append(selec)
            
        }
        var totRect = CGRect.zero
        for vi in scroll.subviews {
            totRect = totRect.union(vi.frame)
        }
        let gr: CGFloat = 0.05
        totRect.size.height += selectView.frame.height*gr
        scroll.contentSize.height = totRect.size.height
        scroll.contentSize.width = view.frame.width
        
        func white(_ alpha: CGFloat)->AnyObject{
            return UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: Float(alpha)).cgColor as AnyObject
        }
        func black(_ alpha: CGFloat)->AnyObject{
            return UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: Float(alpha)).cgColor as AnyObject
        }
        
        grad = CAGradientLayer()
        grad.frame = selectView.bounds
        grad.colors = [white(0.0), white(1.0)]
        grad.startPoint = CGPoint(x: 0, y: (1.0-gr))
        grad.endPoint = CGPoint(x: 0, y: 1)
        
        let h1: CGFloat = 10.0
        let grad1 = CAGradientLayer()
        grad1.frame = CGRect(x: 0, y: downSpace+mar-h1/2, width: selectView.frame.width, height: h1)
        grad1.colors = [white(0.0),white(0.5), white(0.0)]
        grad1.startPoint = CGPoint(x: 0, y: 0)
        grad1.endPoint = CGPoint(x: 0, y: 0.9)
        
        let upperGrad = CAGradientLayer()
        upperGrad.frame = upperView.bounds
        upperGrad.colors = [UIColor(hue: 0.0, saturation: 0.0, brightness: 1.0, alpha: 1.0).cgColor as AnyObject, UIColor(hue: 0.0, saturation: 0.0, brightness: 1.0, alpha: 1.0).cgColor as AnyObject]
        upperGrad.startPoint = CGPoint(x: 0, y: 0)
        upperGrad.endPoint = CGPoint(x: 0, y: 1)
        
        let downGrad = CAGradientLayer()
        downGrad.frame = CGRect(x: 0, y: downSpace+mar, width: selectView.frame.width, height: selectView.frame.height-(downSpace+mar))
        downGrad.colors = [(upperGrad.colors?[1])!, UIColor(hue: 0.0, saturation: 0.0, brightness: 1.0, alpha: 1.0).cgColor as AnyObject]
        downGrad.startPoint = CGPoint(x: 0, y: 0)
        downGrad.endPoint = CGPoint(x: 0, y: 1)
        
        let uppUppGrad = CAGradientLayer()
        uppUppGrad.frame = CGRect(x: 0, y: 0, width: selectView.frame.width, height: mar)
        uppUppGrad.colors = [UIColor(hue: 0.0, saturation: 0.0, brightness: 1.0, alpha: 1.0).cgColor as AnyObject, (upperGrad.colors?[0])!]
        uppUppGrad.startPoint = CGPoint(x: 0, y: 0)
        uppUppGrad.endPoint = CGPoint(x: 0, y: 1)
        
        let fontSize: CGFloat = 35.0
        
        let label = UILabel()
        label.text = "HT ÅK 8"
        label.font = UIFont(name: (label.font?.fontName)!, size: fontSize)
        label.sizeToFit()
        label.frame.origin.x = upperView.frame.width/2-label.frame.width/2
        label.frame.origin.y = upperView.frame.height/2-label.frame.height/2
        
        
        
        let btnLeft = UIButton()
        btnLeft.setTitle("<", for: [])
        btnLeft.titleLabel?.font = UIFont(name: (btnLeft.titleLabel?.font.fontName)!, size: fontSize)
        btnLeft.setTitleColor(UIColor.black(), for: [])
        btnLeft.sizeToFit()
        btnLeft.frame.origin.x = label.frame.origin.x-btnLeft.frame.width-10.0
        btnLeft.frame.origin.y = upperView.frame.height/2-btnLeft.frame.height/2
        
        let btnRight = UIButton()
        btnRight.setTitle(">", for: [])
        btnRight.titleLabel?.font = UIFont(name: (btnRight.titleLabel?.font.fontName)!, size: fontSize)
        btnRight.setTitleColor(UIColor.black(), for: [])
        btnRight.sizeToFit()
        btnRight.frame.origin.x = label.frame.origin.x+label.frame.width+10.0
        btnRight.frame.origin.y = upperView.frame.height/2-btnRight.frame.height/2
        
        selectView.layer.addSublayer(downGrad)
        selectView.layer.addSublayer(uppUppGrad)
        upperView.layer.addSublayer(upperGrad)
        upperView.addSubview(label)
        upperView.addSubview(btnLeft)
        upperView.addSubview(btnRight)
        selectView.addSubview(scroll)
        selectView.layer.addSublayer(grad)
        selectView.layer.addSublayer(grad1)
        selectView.addSubview(upperView)
        selectView.layer.addSublayer(grad1)
        
        //schoolView
        
        
        schoolScroll.frame = view.frame
        schoolScroll.frame.size.height -= downSpace
        schoolScroll.frame.origin.y = downSpace
        
        
        
        let text = UILabel()
        text.text = "Sorry, something went to shit..."
        text.font = UIFont(name: (text.font?.fontName)!, size: 25.0)
        text.sizeToFit()
        text.frame.origin.x = schoolView.frame.width/2-text.frame.width/2
        text.frame.origin.y = schoolView.frame.height/2-text.frame.height/2
        
        
        
        
        
        
        let ma: CGFloat = 30.0
        let inp = UITextField()
        inp.frame.size = CGSize(width: view.frame.width-ma, height: 30)
        
        inp.frame.origin.x = view.frame.width/2-inp.frame.width/2
        inp.frame.origin.y = downSpace-inp.frame.height-5.0
        inp.borderStyle = UITextBorderStyle.roundedRect
        inp.returnKeyType = UIReturnKeyType.done
        inp.clearButtonMode = UITextFieldViewMode.whileEditing
        inp.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        inp.placeholder = "Sök skola"
        inp.layer.borderColor = UIColor.black().cgColor
        inp.delegate = self
        
        
        
        //inp.backgroundColor = UIColor.gray()
        //schoolView.backgroundColor = UIColor.green()
        //schoolScroll.backgroundColor = UIColor.white()
        schoolView.addSubview(inp)
        
        schoolView.addSubview(schoolScroll)
        //schoolView.addSubview(text)
        //view
        
        mainScroll.addSubview(statView)
        mainScroll.addSubview(selectView)
        mainScroll.addSubview(schoolView)
        view.addSubview(mainScroll)
        
        
        //falsify(v: self.view)
        mainScroll.scrollsToTop = false
        scroll.scrollsToTop = false
        schoolScroll.scrollsToTop = true
        schoolScroll.delegate = self
    }
    
    func falsify(v: UIView){
        if let a = v as? UIScrollView{
            a.scrollsToTop = false
            print("FALSE")
        }
        for sv in v.subviews {
            //print("FALSE-")
            falsify(v: sv)
        }
    }
    
    func json(_ data: String){
        do{
            let dataData = data.data(using: String.Encoding.utf8)
            let jsonData = try JSONSerialization.jsonObject(with: dataData!, options: JSONSerialization.ReadingOptions.allowFragments)
            if let utbild = jsonData["utbildningar"] as? [[String: [[String: AnyObject]]]]{
                for kommunobj in utbild {
                    for namn in kommunobj.keys {
                        //print("KEYS: \(namn)")
                        
                        if let komu = kommunobj[namn]{
                            let komm = kommun(namn: namn)
                            for program in komu {
                                let pr = Prog()
                                for prop in program.keys {
                                    if let val = program[prop] as? String{
                                        switch val {
                                        case "1)":
                                            pr[prop] = -1.0
                                        case "2)":
                                            pr[prop] = -2.0
                                        case "3)":
                                            pr[prop] = -3.0
                                        case "4)":
                                            pr[prop] = -4.0
                                        case "5)":
                                            pr[prop] = -4.0
                                        default:
                                            pr[prop] = val
                                        }
                                        
                                    }
                                    else if let val = program[prop] as? Float{
                                        pr[prop] = val
                                    }
                                    else{
                                        pr[prop] = -10.0 as Float
                                    }
                                }
                                komm.program.append(pr)
                            }
                            kommuner.append(komm)
                        }
                        
                    }
                    
                }
                for kommun in kommuner {
                    for program in kommun.program {
                        var txt = UIView()
                        if program.antSlut != nil{
                            txt = makeStdView("\(program.namn), \(program.program)", p: program.antSlut!)
                        }
                        else{
                            txt = makeStdView("\(program.namn), \(program.program)", p: 0.0)
                        }
                        addViewToList(txt)
                    }
                }
                schoolScrollViews.sort(isOrderedBefore: sortView)
                for v in schoolScrollViews {
                    addView(v)
                }
            }
            else{
                print("e")
            }
            
        }catch{
            print("Error: \(error)")
        }
    }
    
    func sortView(_ v1: UIView, v2: UIView)->Bool{
        let txt1 = v1.subviews[1] as! UILabel
        let txt2 = v2.subviews[1] as! UILabel
        let f1 = (txt1.text! as NSString).floatValue
        let f2 = (txt2.text! as NSString).floatValue
        return f1 > f2
    }
    
    func addViewToList(_ v: UIView){
        schoolScrollViews.append(v)
    }
    
    func addView(_ v: UIView){
        var totRect = CGRect.zero
        for vi in schoolScroll.subviews {
            totRect = totRect.union(vi.frame)
        }
        totRect.size.height += 0.0
        schoolScroll.contentSize = totRect.size
        v.frame.origin.y = totRect.size.height
        schoolScroll.addSubview(v)
        totRect = CGRect.zero
        for vi in schoolScroll.subviews {
            totRect = totRect.union(vi.frame)
        }
        totRect.size.height += 0.0
        schoolScroll.contentSize = totRect.size
    }
    
    func presentModal(){
        self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
        let m = modalViewController()
        m.pr = current
        self.present(m, animated: true, completion: nil)
    }
    
    func btnPress(_ sender: UIButton){
        if let la = sender.superview?.subviews[0] as? UILabel{
            for kommun in kommuner {
                for program in kommun.program {
                    if("\(program.namn), \(program.program)" == la.text){
                        current = program
                    }
                }
            }
        }
        presentModal()
    }
    
    func makeStdView(_ str: String, p: Float)->UIView{
        let v = UIView()
        let h = view.frame.height/10.0
        v.frame.size = CGSize(width: view.frame.width, height: h)
        
        let l = UILabel()
        l.font = UIFont(name: (l.font?.fontName)!, size: 15.0)
        l.text = str
        l.sizeToFit()
        if(l.frame.width>schoolView.frame.width-50.0){
            l.frame.size.width = schoolView.frame.width-100.0
        }
        l.lineBreakMode = NSLineBreakMode.byTruncatingTail
        l.frame.origin.x = 10.0
        l.frame.origin.y = h/2-l.frame.size.height/2
        v.addSubview(l)
        let l1 = UILabel()
        if p >= 0.0{
            l1.text = String(p)
            
        }
        else if p == -1.0 {
            l1.text = "0"
            
        }
        else if p == -2.0{
            l1.text = "0"
        
        }else if p == -3.0{
            l1.text = "0"
        
        }else if p == -4.0{
            l1.text = "0"
        
        }else if p == -5.0{
            l1.text = "0"
            
        }
        else{
            l1.text = "0"
        }
        
        l1.sizeToFit()
        l1.frame.origin.x = v.frame.width-l1.frame.width-10.0
        l1.frame.origin.y = h/2-l1.frame.size.height/2
        v.addSubview(l1)
        if(p<=0){
            v.backgroundColor = okColor
        }
        let btn = UIButton()
        btn.frame.size = v.frame.size
        btn.addTarget(self, action: #selector(btnPress), for: UIControlEvents.touchUpInside)
        v.addSubview(btn)
        return v
    }
    
    func segCh(_ sender: UISegmentedControl){
        var tot: Float = 0.0
        for se in segments{
            if(se.selectedSegmentIndex>0){
                let i = (Float(se.selectedSegmentIndex-1)*2.5)+10
                //print(i)
                tot += i
            }
        }
        var str = ""
        if(tot<10){
            str = "00" + String(tot)
        }
        else if(tot<100){
            str = "0" + String(tot)
        }
        else{
            str = String(tot)
        }
        poängLabel.text = str
        poängLabel.sizeToFit()
        poängLabel.frame.origin = CGPoint(x: statView.frame.width/2-poängLabel.frame.width/2, y: 20.0)
        //print(str)
        cleared = 0
        for v in schoolScrollViews {
            let t = v.subviews[1] as! UILabel
            let f = (t.text! as NSString).floatValue
            if(f<=tot){
                v.backgroundColor = okColor
                cleared += 1
            }
            else{
                v.backgroundColor = UIColor.white()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let vScroll = schoolScroll.showsVerticalScrollIndicator
        let hScroll = schoolScroll.showsHorizontalScrollIndicator
        schoolScroll.showsHorizontalScrollIndicator = false
        schoolScroll.showsVerticalScrollIndicator = false
        if(textField.text != ""){
            for s in schoolScrollViews {
                s.removeFromSuperview()
            }
            for subView in schoolScrollViews {
                if(subView.subviews.count>0){
                    if let l = subView.subviews[0] as? UILabel{
                        if(l.text?.lowercased().range(of: textField.text!.lowercased()) != nil){
                            if(subView.superview == nil){
                                schoolScroll.addSubview(subView)
                            }
                        }else{
                            subView.removeFromSuperview()
                        }
                    }
                }
            }
            
            
        }
        else{
            for s in schoolScrollViews {
                s.removeFromSuperview()
            }
            for subView in schoolScrollViews {
                if(subView.superview == nil){
                    schoolScroll.addSubview(subView)
                }
            }
        }
        for (i, sview) in schoolScroll.subviews.enumerated() {
            sview.frame.origin.y = sview.frame.height*CGFloat(i)
        }
        var totRect = CGRect.zero
        for vi in schoolScroll.subviews {
            totRect = totRect.union(vi.frame)
        }
        totRect.size.height += 0.0
        schoolScroll.contentSize = totRect.size
        schoolScroll.showsVerticalScrollIndicator = vScroll
        schoolScroll.showsHorizontalScrollIndicator = hScroll
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


