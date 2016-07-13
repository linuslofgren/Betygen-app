//
//  ViewController.swift
//  Betyg
//
//  Created by Linus Löfgren on 2016-06-17.
//  Copyright © 2016 Linus Löfgren. All rights reserved.
//

import UIKit


//TODO: schoolScrollViews
enum Betyg: Float {
    case F = 0.0
    case E = 10.0
    case D = 12.5
    case C = 15.0
    case B = 17.5
    case A = 20.0
    static let allBetyg = [F,E,D,C,B,A]
    
}

enum Ämnen: String{
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
    case ModernaSpråk
    case CSpråk
    static let allÄmnen = [Bild, Biologi,Engelska,Fysik,Geografi,Hemochkonsumentkunskap,Historia,Idrott,Kemi,Matematik,Musik,Religionskunskap,Samhällskunskap,Slöjd,Svenska,Teknik,ModernaSpråk,CSpråk]
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
    
    var semesters: [String] = []
    var gradesForSemesters: [[Ämnen: Betyg]] = []
    
    
    let headerLabel = UILabel()
    
    var _semester = 0
    
    var semester: Int{
        set (num){
            if(semesters.count>0){
                if(num>semesters.count-1){
                    _semester = semesters.count-1
                }
                else if(num<0){
                    _semester = 0
                }
                else{
                    _semester = num
                }
            }
            
        }
        get{
            return _semester
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        semester = 4
        // Do any additional setup after loading the view, typically from a nib.
        for i in 6...9{
            semesters.append("HT ÅK \(i)")
            semesters.append("VT ÅK \(i)")
        }
        
        if let tempGrades = getBetyg(){
           gradesForSemesters = tempGrades
        }
        else{
            for sem in semesters {
                var dic = [Ämnen: Betyg]()
                for grade in Ämnen.allÄmnen {
                    dic[grade] = Betyg.F
                }
                gradesForSemesters.append(dic)
            }
        }
        for (i, e) in semesters.enumerated() {
            //print(gradesForSemesters[i])
        }
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
        
        
        
        
        
        
        
        for (i, e) in Ämnen.allÄmnen.enumerated(){
            let la = UILabel()
            la.font = UIFont.systemFont(ofSize: 30.0)
            if(e == Ämnen.Hemochkonsumentkunskap){
                la.text = "Hem- och konsumentkunskap"
            }
            else if(e == Ämnen.Idrott){
                la.text = "Idrott och Hälsa"
            }
            else if(e == Ämnen.ModernaSpråk){
                la.text = "Moderna Språk"
            }
            else if(e == Ämnen.CSpråk){
                la.text = "C-Språk"
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
        resSe()
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
        
        
        headerLabel.text = semesters[semester]
        headerLabel.font = UIFont(name: (headerLabel.font?.fontName)!, size: fontSize)
        headerLabel.sizeToFit()
        headerLabel.frame.origin.x = upperView.frame.width/2-headerLabel.frame.width/2
        headerLabel.frame.origin.y = upperView.frame.height/2-headerLabel.frame.height/2
        
        
        
        let btnLeft = UIButton()
        btnLeft.setTitle("<", for: [])
        btnLeft.titleLabel?.font = UIFont(name: (btnLeft.titleLabel?.font.fontName)!, size: fontSize)
        btnLeft.setTitleColor(UIColor.black(), for: [])
        btnLeft.sizeToFit()
        btnLeft.frame.origin.x = headerLabel.frame.origin.x-btnLeft.frame.width-10.0
        btnLeft.frame.origin.y = upperView.frame.height/2-btnLeft.frame.height/2
        btnLeft.addTarget(self, action: #selector(lower), for: UIControlEvents.touchUpInside)
        
        let btnRight = UIButton()
        btnRight.setTitle(">", for: [])
        btnRight.titleLabel?.font = UIFont(name: (btnRight.titleLabel?.font.fontName)!, size: fontSize)
        btnRight.setTitleColor(UIColor.black(), for: [])
        btnRight.sizeToFit()
        btnRight.frame.origin.x = headerLabel.frame.origin.x+headerLabel.frame.width+10.0
        btnRight.frame.origin.y = upperView.frame.height/2-btnRight.frame.height/2
        btnRight.addTarget(self, action: #selector(incr), for: UIControlEvents.touchUpInside)
        
        selectView.layer.addSublayer(downGrad)
        selectView.layer.addSublayer(uppUppGrad)
        upperView.layer.addSublayer(upperGrad)
        upperView.addSubview(headerLabel)
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
    
    func lower(){
        
        semester -= 1
        headerLabel.text = semesters[semester]
        resSe()
        segCh(UISegmentedControl())
    }
    func incr(){
        semester += 1
        headerLabel.text = semesters[semester]
        resSe()
        segCh(UISegmentedControl())
    }
    
    func resSe(){
        for (i,se) in segments.enumerated(){
            let gr: Betyg = gradesForSemesters[semester][Ämnen.allÄmnen[i]]!
            if(gr == .F){
                se.selectedSegmentIndex = 0
            }
            else{
                let index = Int((((gr.rawValue-10)/2.5))+1)
                se.selectedSegmentIndex = index
            }
            
        }
    }
    
    func falsify(v: UIView){
        if let a = v as? UIScrollView{
            a.scrollsToTop = false
            //print("FALSE")
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
                //print("e")
            }
            
        }catch{
            //print("Error: \(error)")
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
    
    func isKärn(ämne: Ämnen)->Bool{
        if ämne == .Svenska || ämne == .Matematik || ämne == .Engelska{
            return true
        }
        else{
            return false
        }
    }
    
    func correctGrades(grades: [Ämnen: Betyg])->Float{
        var tot: Float = 0.0
        var cSpråk = false
        var lowest: Float?
        for (ämne, betyg) in grades {
            if lowest != nil {
                if betyg.rawValue < lowest && !isKärn(ämne: ämne) && betyg != .F{
                    lowest = betyg.rawValue
                }
            }
            else{
                if !isKärn(ämne: ämne) && betyg != .F{
                    lowest = betyg.rawValue
                }
            }
            if ämne == .CSpråk {
                cSpråk = true
                continue
            }
            tot += betyg.rawValue
        }
        if cSpråk && lowest != nil{
            if grades[.CSpråk]?.rawValue > lowest{
                tot -= lowest!
                tot += (grades[.CSpråk]?.rawValue)!
            }
        }
        return tot
    }
    
    func saveBetyg(){
        var ster = [[String: Float]]()
        for ämneBetyg in gradesForSemesters {
            var dic = [String: Float]()
            for (ämne, betyg) in ämneBetyg {
                dic[ämne.rawValue] = betyg.rawValue
            }
            ster.append(dic)
            
        }
        let def = UserDefaults.standard()
        def.set(ster, forKey: "GRADES")
    }
    
    func getBetyg()->[[Ämnen: Betyg]]?{
        let def = UserDefaults.standard()
        if let ster = def.array(forKey: "GRADES") as? [[String: Float]]{
            var ämnenBetyg = [[Ämnen: Betyg]]()
            for strFlo in ster {
                var arr = [Ämnen: Betyg]()
                for (str, flo) in strFlo {
                    if let ämn = Ämnen(rawValue:str){
                        if let bet = Betyg(rawValue: flo){
                            arr[ämn] = bet
                        }
                        else{break}
                    }
                    else{break}
                }
                
                ämnenBetyg.append(arr)
            }
            return ämnenBetyg
        }
        return nil
    }
    
    func segCh(_ sender: UISegmentedControl){
        saveBetyg()
        var tot: Float = 0.0
        for (i, se) in segments.enumerated(){
            if(se.selectedSegmentIndex>0){
                let j = (Float(se.selectedSegmentIndex-1)*2.5)+10
                //print(j)
                for betyg in Betyg.allBetyg {
                    if(betyg.rawValue == j){
                        gradesForSemesters[semester][Ämnen.allÄmnen[i]] = betyg
                        break
                    }
                }
                
            }
            else{
                gradesForSemesters[semester][Ämnen.allÄmnen[i]] = .F
            }
        }
        tot = correctGrades(grades: gradesForSemesters[semester])
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
        saveBetyg()
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


