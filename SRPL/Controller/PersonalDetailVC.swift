//
//  PersonalDetailVC.swift
//  SRPL
//
//  Created by ADMS on 14/09/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import ProgressHUD
import Toast_Swift

class PersonalDetailVC: UIViewController,UITextFieldDelegate {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtState: UITextField!
    @IBOutlet var txtPincode: UITextField!

    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        lblTitle.text = NSLocalizedString("srpl_Personal Details", comment: "")
//        btnBack.setTitle("srpl_Back".localized(), for: .normal)
        btnBack.setTitle(NSLocalizedString("srpl_Back", comment: ""), for: .normal)
        txtPhone.delegate = self
       // self.txtName.delegate = self
        self.txtName.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)
        self.txtCity.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)
        self.txtState.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)

//        btnBack.setAttributedTitle(NSLocalizedString("srpl_Back", comment: ""), for: .normal)

//        self.title = "Personal Detail"
    }
    @objc func firstResponderAction()
    {
        self.view.endEditing(true)
    }
    @IBAction func btnBackClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClickAddCarDetail(_sender:UIButton)
    {

        if validated() == true
        {
            callApiPersionalDetail()
        }
    }

    func validated() -> Bool
    {
        var valid: Bool = true

        let txtname = txtName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtcity = txtCity.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtphone =  txtPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtpincode = txtPincode.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtstate = txtState.text!.trimmingCharacters(in: .whitespacesAndNewlines)


        if txtname == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation1", comment: ""))
            valid = false
        }else if txtphone == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation2", comment: ""))
            valid = false
        }
        else if (txtphone.count < 10)
        {
            self.view.makeToast(NSLocalizedString("srpl_validation3", comment: ""))
            valid = false
        }
        else if txtcity == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation4", comment: ""))
            valid = false
        }
        else if txtstate == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation6", comment: ""))
            valid = false
        }
        else if txtpincode == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation5", comment: ""))
            valid = false
        }
        return valid
    }

    
}
extension PersonalDetailVC{
    func callApiPersionalDetail()
    {
        ProgressHUD.show()
        var params = [String:Any]()

        guard let name = txtName.text, let city = txtCity.text ,let phone = txtPhone.text,let pincode = txtPincode.text,let state = txtState.text else {
            return
        }

        params = ["Name":name,"Mobile":phone,"City":city,"State":state,"Pincode":pincode,"StatusId":"1","IsActive":"true"]


        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
//            "application/json": "Accept"
        ]
//        let headers: HTTPHeaders = [
//            "Content-Type": "text/xml; charset=utf-8",
////            "Accept": "application/json"
//
//        ]


        // Hide
        print("API, Params: \n",API.AddCustomer)
        if !Connectivity.isConnectedToInternet() {
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }


//        let request = URLRequest(url: URL(string:API.AddCustomer)!)
//        Alamofire.request(request).validate(statusCode: 200..<300).responseJSON { (response) in
//            switch response.result {
//            case .success(let data as [String:Any]): break
////                completion(true,data)
//            case .failure(let err):
//                print(err.localizedDescription)
////                completion(false,err)
//            default:
//                break
////                completion(false,nil)
//            }
//        }




//        var request = URLRequest(url: URL(string: API.AddCustomer)!)
//        request.httpMethod = "POST"
//
//        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            if let error = error {
//                ProgressHUD.dismiss()
//                print(error); return
//            }
//            guard let data = data else { print("Data is missing."); return }
//            do {
//
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(json)
//            } catch let e {
//                print("Parse error: \(e)")
//            }
//        }).resume()


        

        Alamofire.request(API.AddCustomer, method: .post, parameters: params, headers: headers).validate().responseJSON { response in

            ProgressHUD.dismiss()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("persion detail",json)

                if(json["status"] == "true") {

                    self.txtName.text = ""
                    self.txtCity.text = ""
                    self.txtPincode.text = ""
                    self.txtPhone.text = ""
                    self.txtState.text = ""

                    UserDefaults.standard.setValue(json["data"].intValue, forKey: "IsCustomerId")
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VehicleTypeVC") as? VehicleTypeVC
                    self.navigationController?.pushViewController(vc!, animated: true)
//                    let arrData = json["data"].array
//                    for value in arrData! {
                        //                        let pckgDetModel:arrMyFeed = arrMyFeed.init(SocialMediaPostUserID: value["SocialMediaPostUserID"].intValue, PostName: value["PostName"].stringValue, PostTitle: value["PostTitle"].stringValue, PostImage: value["PostImage"].stringValue, PostDescription: value["PostDescription"].stringValue, PostCreateDate: value["PostCreateDate"].stringValue, Comment_Count: value["Comment_Count"].intValue,Share_Count: value["Share_Count"].intValue,Like_Count: value["Like_Count"].intValue,Islike: value["Islike"].boolValue,IsShare: value["IsShare"].boolValue,UserID: value["UserID"].intValue)
                        //                        self.arrMyFeedList.append(pckgDetModel)
//                    }
//                    DispatchQueue.main.async {
//                         self.tblFeed.reloadData()
//                    }

                }else
                {
                    self.view.makeToast(NSLocalizedString("srpl_validation15", comment: ""), duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                ProgressHUD.dismiss()

                
//                self.view.makeToast(NSLocalizedString("srpl_validation15", comment: ""), duration: 3.0, position: .bottom)
                if !Connectivity.isConnectedToInternet() {
                    print("The network is not reachable")
                    // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                    return
                }
                //  self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

                //Bhargav Hide
                print(error.localizedDescription)
            }
        }
    }
}
extension PersonalDetailVC{

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            if textField == txtPhone
            {
                let charsLimit = 10

                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace =  range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace

                return newLength <= charsLimit
            }
           else if textField == txtPincode
            {
                let charsLimit = 6

                let startingLength = textField.text?.count ?? 0
                let lengthToAdd = string.count
                let lengthToReplace =  range.length
                let newLength = startingLength + lengthToAdd - lengthToReplace

                return newLength <= charsLimit

            }
           else{
            return true
           }

        }
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        //textField code
        self.view.endEditing(true)

        //textField.resignFirstResponder()  //if desired
       // performAction()
        return false
    }
}
