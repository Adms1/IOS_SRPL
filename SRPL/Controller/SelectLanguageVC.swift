//
//  SelectLanguageVC.swift
//  SRPL
//
//  Created by ADMS on 17/09/21.
//

import UIKit

class SelectLanguageVC: UIViewController {

    @IBOutlet weak var btnEnglish:UIButton!
    @IBOutlet weak var btnGujarati:UIButton!
    @IBOutlet weak var btnHindi:UIButton!


    @IBOutlet weak var vwEnglish:UIView!
    @IBOutlet weak var vwGujarati:UIView!
    @IBOutlet weak var vwHindi:UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

        btnEnglish.layer.cornerRadius = 6.0
        btnEnglish.layer.masksToBounds = true

        vwEnglish.layer.cornerRadius = 6.0
        vwEnglish.layer.masksToBounds = true


        btnHindi.layer.cornerRadius = 6.0
        btnHindi.layer.masksToBounds = true

        vwGujarati.layer.cornerRadius = 6.0
        vwGujarati.layer.masksToBounds = true


        btnGujarati.layer.cornerRadius = 6.0
        btnGujarati.layer.masksToBounds = true
        
        vwHindi.layer.cornerRadius = 6.0
        vwHindi.layer.masksToBounds = true


        self.navigationController?.navigationBar.isHidden = false

        self.title = "Please select your language"


        btnEnglish.layer.cornerRadius = 4.0
        btnEnglish.layer.masksToBounds = true

        btnGujarati.layer.cornerRadius = 4.0
        btnGujarati.layer.masksToBounds = true

        btnHindi.layer.cornerRadius = 4.0
        btnHindi.layer.masksToBounds = true

    }

    @IBAction func btnClickLanguage(_sender:UIButton)
    {
        if _sender.tag == 100
        {
            Bundle.set(language: "en")
            UserDefaults.standard.setValue("en", forKey:"ISLanguage")
            UserDefaults.standard.setValue(1, forKey:"langType")
        }else if _sender.tag == 101
        {
            Bundle.set(language: "hi")
           // Bundle.localizedBundle()
            UserDefaults.standard.setValue("hi", forKey:"ISLanguage")
            UserDefaults.standard.setValue(2, forKey:"langType")
        }else if _sender.tag == 102{
            Bundle.set(language: "gu")
           // Bundle.localizedBundle()
            UserDefaults.standard.setValue("gu", forKey:"ISLanguage")
            UserDefaults.standard.setValue(3, forKey:"langType")
        }

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PersonalDetailVC") as? PersonalDetailVC
        self.navigationController?.pushViewController(vc!, animated: true)



    }

}


