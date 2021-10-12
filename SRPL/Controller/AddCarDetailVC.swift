//
//  AddCarDetailVC.swift
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
import ActionSheetPicker_3_0


class AddCarDetailVC: UIViewController, UITextFieldDelegate{


//    @IBOutlet var tblCarDetail: UITableView!
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var switch2: UISwitch!
    @IBOutlet var switch3: UISwitch!
    @IBOutlet var switch4: UISwitch!

    @IBOutlet var txtMake: UITextField!
    @IBOutlet var txtModel: UITextField!
    @IBOutlet var txtVarient: UITextField!
    @IBOutlet var txtYear: UITextField!
    @IBOutlet var txtFuel: UITextField!
    @IBOutlet var txtCar: UITextField!

    @IBOutlet var btnPhotos: UIButton!
    @IBOutlet var btnFuel: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblTitle: UILabel!
//    let picker: UIPickerView!

    var vehicleType:Int = -1
    var strVehicleTitle:String = ""

    let pickerData = [NSLocalizedString("srpl_Petrol", comment: ""),NSLocalizedString("srpl_Diesel", comment: ""),NSLocalizedString("srpl_Electric", comment: ""),NSLocalizedString("srpl_CNG", comment: "")]

    var picker: UIPickerView!
    let toolBar = UIToolbar()
    override func viewDidLoad() {

        // chnages upload or not check

        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        self.txtMake.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)
        self.txtModel.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)
        self.txtVarient.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)
        self.txtCar.addTarget(nil, action:Selector("firstResponderAction:"), for:.editingDidEndOnExit)

        btnFuel.isHidden = true
        switch1.layer.cornerRadius = switch1.layer.frame.height/2
        switch1.layer.masksToBounds = true

        switch2.layer.cornerRadius = switch2.layer.frame.height/2
        switch2.layer.masksToBounds = true


        switch3.layer.cornerRadius = switch3.layer.frame.height/2
        switch3.layer.masksToBounds = true

        switch4.layer.cornerRadius = switch4.layer.frame.height/2
        switch4.layer.masksToBounds = true

      //  lblTitle.text = NSLocalizedString("srpl_Add Car Details", comment: "")

        if (strVehicleTitle == "Car" || strVehicleTitle == "कार" || strVehicleTitle == "કાર")
        {
            lblTitle.text = NSLocalizedString("srpl_please_add", comment: "") + NSLocalizedString("srpl_car", comment: "")
        }else if (strVehicleTitle == "Bus" || strVehicleTitle == "बस" || strVehicleTitle == "બસ")
        {
            lblTitle.text = NSLocalizedString("srpl_please_add", comment: "") + NSLocalizedString("srpl_Bus", comment: "")
        }else if (strVehicleTitle == "Truck" || strVehicleTitle == "ट्रक" || strVehicleTitle == "ટ્રક")
        {
            lblTitle.text = NSLocalizedString("srpl_please_add", comment: "") + NSLocalizedString("srpl_Truck", comment: "")
        }else if (strVehicleTitle == "2 Wheelers" || strVehicleTitle == "2 व्हीलर" || strVehicleTitle == "2 વ્હીલર્સ")
        {
            lblTitle.text = NSLocalizedString("srpl_please_add", comment: "") + NSLocalizedString("srpl_2Wheelers", comment: "")
        }else if (strVehicleTitle == "3 Wheelers" || strVehicleTitle == "3 व्हीलर" || strVehicleTitle == "3 વ્હીલર્સ")
        {
            lblTitle.text = NSLocalizedString("srpl_please_add", comment: "") + NSLocalizedString("srpl_3Wheelers", comment: "")
        }


       // lblTitle.text = strVehicleTitle


        btnBack.setTitle(NSLocalizedString("srpl_Back", comment: ""), for: .normal)

//        self.title = "Car Detail"
//        self.navigationController?.navigationBar.isHidden = false

        if !switch1.isOn
        {
            switch1.tintColor = UIColor.lightGray
        }

        if !switch2.isOn
        {
            switch1.tintColor = UIColor.lightGray
        }
        if !switch3.isOn
        {
            switch1.tintColor = UIColor.lightGray
        }
        if !switch4.isOn
        {
            switch1.tintColor = UIColor.lightGray
        }

        switch1.isOn = false
        switch2.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        print("switch1",switch1.isOn)
        print("switch2",switch2.isOn)
        print("switch3",switch3.isOn)
        print("switch4",switch4.isOn)

//        self.picker.dataSource = self
//        self.picker.delegate = self

    }
    @objc func firstResponderAction()
    {
        self.view.endEditing(true)
    }
    @IBAction func btnBackClick()
    {
        self.navigationController?.popViewController(animated: true)
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        let tableviewHeight = self.tblCarDetail.frame.height
//        let contentviewHeight = self.tblCarDetail.contentSize.height
//
//        let centering = (tableviewHeight - contentviewHeight) / 2.0
//        let topInset = max(centering, 0.0)
//
//
//        self.tblCarDetail.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
//
//    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIScreen.main.bounds.height
//    }

    @IBAction func switch1Changed(switch1: UISwitch) {
        if switch1.isOn {
            switch1.isOn = true
            print("UISwitch is ON")
            switch1.onTintColor = UIColor(hexString: "#062C5E")
        } else {
            //   switchState.text = "UISwitch is OFF"
            print("UISwitch is OFF")
            switch1.isOn = false
        }
    }

    @IBAction func switch2Changed(switch2: UISwitch) {
        if switch2.isOn {
            switch2.isOn = true
            print("UISwitch is ON")
            switch2.onTintColor = UIColor(hexString: "#062C5E")
        } else {
            //   switchState.text = "UISwitch is OFF"
            print("UISwitch is OFF")
            switch2.isOn = false
            //switch1.tintColor = UIColor.darkGray
        }
    }


    @IBAction func switch3Changed(switch3: UISwitch) {
        if switch3.isOn {
            switch3.isOn = true
            print("UISwitch is ON")
            switch3.onTintColor = UIColor(hexString: "#062C5E")
        } else {
            //   switchState.text = "UISwitch is OFF"
            print("UISwitch is OFF")
            switch3.isOn = false
        }
    }

    @IBAction func switch4Changed(switch4: UISwitch) {
        if switch4.isOn {
            switch4.isOn = true
            print("UISwitch is ON")
            switch4.onTintColor = UIColor(hexString: "#062C5E")
        } else {
            //   switchState.text = "UISwitch is OFF"
            print("UISwitch is OFF")
            switch4.isOn = false
        }
    }


    @IBAction func btnClickAddPhoto(_sender:UIButton)
    {
        self.view.endEditing(true)
        if validated() == true
        {
            callApiAddCarDetail()
        }
    }

    func validated() -> Bool
    {
        var valid: Bool = true

        let txtmake = txtMake.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtmodel = txtModel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtvarient =  txtVarient.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtyear = txtYear.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtfuel = txtFuel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let txtcar = txtCar.text!.trimmingCharacters(in: .whitespacesAndNewlines)


        if txtmake == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation7", comment: ""))
            valid = false
        }else if txtmodel == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation8", comment: ""))
            valid = false
        }
        else if txtvarient == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation9", comment: ""))
            valid = false
        }
        else if txtyear == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation10", comment: ""))
            valid = false
        }
        else if txtfuel == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation11", comment: ""))
            valid = false
        }else if txtcar == ""
        {
            self.view.makeToast(NSLocalizedString("srpl_validation12", comment: ""))
            valid = false
        }
        return valid
    }

    func pickUp(_ textField : UITextField){

    // UIPickerView
    self.picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
    self.picker.delegate = self
    self.picker.dataSource = self
    self.picker.backgroundColor = UIColor.lightGray
        txtFuel.inputView = self.picker

    // ToolBar
    let toolBar = UIToolbar()
    toolBar.barStyle = .default
//    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
    toolBar.sizeToFit()

    // Adding Button ToolBar
    let doneButton = UIBarButtonItem(title: NSLocalizedString("srpl_done", comment: ""), style: .plain, target: self, action: #selector(self.doneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: NSLocalizedString("srpl_cancel", comment: ""), style: .plain, target: self, action: #selector(self.doneClick))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    txtFuel.inputAccessoryView = toolBar

     }


    @IBAction func clickOnFuel(sender: AnyObject) {
//        ActionSheetStringPicker.show(withTitle: NSLocalizedString("srpl_fuel_type", comment: ""),
//                                     rows: [NSLocalizedString("srpl_Petrol", comment: ""),NSLocalizedString("srpl_Diesel", comment: ""),NSLocalizedString("srpl_Electric", comment: ""),NSLocalizedString("srpl_CNG", comment: "")],
//                                     initialSelection: 0,
//                                     doneBlock: { picker, value, index in
//                                        print("picker = \(String(describing: picker))")
//                                        print("value = \(value)")
//                                        print("index = \(String(describing: index))")
//                                        self.txtFuel.text = index! as? String
//                                        return
//                                     },
//                                     cancel: { picker in
//                                        return
//                                     },
//                                     origin: btnFuel)

    }

    @objc func doneClick() {
        self.view.endEditing(true)
        txtFuel.resignFirstResponder()
    }
}
extension AddCarDetailVC:UIPickerViewDataSource,UIPickerViewDelegate
{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }

//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }

//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
//
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        txtFuel.text = pickerData[row]
//    }
//
//   @objc func donePicker() {
//
//    txtFuel.resignFirstResponder()
//
//    }



    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtFuel.text = self.pickerData[row]
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
   self.pickUp(txtFuel)
    }



}
extension AddCarDetailVC{
    func callApiAddCarDetail()
    {
        ProgressHUD.show()
        var params = [String:Any]()

        guard let make = txtMake.text, let model = txtModel.text ,let varient = txtVarient.text,let year = txtYear.text,let fuel = txtFuel.text,let car = txtCar.text else {
            return
        }

         let cusId = UserDefaults.standard.integer(forKey: "IsCustomerId")

        params = ["CustomerID": "\(cusId)","Make": make,"Model": model,"Varient": varient,"Year": year,"FuelType": fuel,"CarNumber": car,"IsWorking":"\(switch1.isOn)","IsAccident":"\(switch2.isOn)","IsPoliceCase":"\(switch3.isOn)","IsRCBook":"\(switch4.isOn)","IsActive":"true","VehicleTypeID":"\(vehicleType)"]


        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.AddVehicleDetail)
        if !Connectivity.isConnectedToInternet() {
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }



        Alamofire.request(API.AddVehicleDetail, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            ProgressHUD.dismiss()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("car detail",json)

                if(json["status"] == "true") {

                    self.txtMake.text = ""
                    self.txtModel.text = ""
                    self.txtVarient.text = ""
                    self.txtYear.text = ""
                    self.txtFuel.text = ""
                    self.txtCar.text = ""
                    self.vehicleType = -1

                    UserDefaults.standard.setValue(json["data"].intValue, forKey: "IsCarID")
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddPhotoVC") as? AddPhotoVC
                    self.navigationController?.pushViewController(vc!, animated: true)

//                    let arrData = json["data"].array
//                    for value in arrData! {
                        //                        let pckgDetModel:arrMyFeed = arrMyFeed.init(SocialMediaPostUserID: value["SocialMediaPostUserID"].intValue, PostName: value["PostName"].stringValue, PostTitle: value["PostTitle"].stringValue, PostImage: value["PostImage"].stringValue, PostDescription: value["PostDescription"].stringValue, PostCreateDate: value["PostCreateDate"].stringValue, Comment_Count: value["Comment_Count"].intValue,Share_Count: value["Share_Count"].intValue,Like_Count: value["Like_Count"].intValue,Islike: value["Islike"].boolValue,IsShare: value["IsShare"].boolValue,UserID: value["UserID"].intValue)
                        //                        self.arrMyFeedList.append(pckgDetModel)
//                    }
//                    DispatchQueue.main.async {
//                         self.tblFeed.reloadData()
//                    }

                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    ProgressHUD.dismiss()
                    print("The network is not reachable")
                    // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                    return
                }
                //  self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

                //Bhargav Hide
                print(error)
            }
        }
    }
}


