//
//  VehicleTypeVC.swift
//  SRPL
//
//  Created by ADMS on 21/09/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import ProgressHUD
import Toast_Swift


class VehicleTypeVC: UIViewController {

    @IBOutlet var tblVehicleList:UITableView!
    @IBOutlet var btnBack:UIButton!
    @IBOutlet var lblNoDataFound:UILabel!
    @IBOutlet var lblTitle:UILabel!

    var isSelectedVehicle:Int = 0


    var cellColors = ["#AE388B","#18A558","#D8581C","#F0BB4C","#E3CB92","#FEA375"]

    var arrVehicleList = [VehicleModelList]()

    override func viewDidLoad() {
        super.viewDidLoad()

        lblNoDataFound.isHidden = true

        self.navigationController?.navigationBar.isHidden = true

        lblTitle.text = NSLocalizedString("srpl_Vehicle", comment: "")
        //        btnBack.setTitle("srpl_Back".localized(), for: .normal)
        btnBack.setTitle(NSLocalizedString("srpl_Back", comment: ""), for: .normal)

    }
    @IBAction func btnBackClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callApiForVehicleType()
    }
}
extension VehicleTypeVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrVehicleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath) as! VehicleCell


        cell.vwColor.layer.cornerRadius = 6.0
        cell.vwColor.layer.masksToBounds = true

        cell.lblVehicleType.text = arrVehicleList[indexPath.row].VehicleType
        cell.vwColor.backgroundColor = UIColor(hexString: cellColors[indexPath.row])
//        cell.vwColor.alpha = 0.1
        cell.lblVehicleType.textColor = UIColor(hexString: cellColors[indexPath.row])



//        if let currLanCode = UserDefaults.standard.string(forKey: "ISLanguage") {
//
//            if (currLanCode == "en")
//            {
//                if (arrVehicleList[indexPath.row].VehicleType == "Car")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_lan", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "Bus")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_bus", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "Truck")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_truck", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "2 Wheelers")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_2wheel", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "3 Wheelers")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_3wheel", comment: "")
//                }
//
//            }else if (currLanCode == "hi"){
//                if (arrVehicleList[indexPath.row].VehicleType == "Car")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_lan", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "Bus")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_bus", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "Truck")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_truck", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "2 Wheelers")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_2wheel", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "3 Wheelers")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_3wheel", comment: "")
//                }
//
//            }else if (currLanCode == "gu"){
//                if (arrVehicleList[indexPath.row].VehicleType == "Car")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_lan", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "Bus")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_bus", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "Truck")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_truck", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "2 Wheelers")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_2wheel", comment: "")
//                }else if (arrVehicleList[indexPath.row].VehicleType == "3 Wheelers")
//                {
//                    cell.lblVehicleType.text = NSLocalizedString("srpl_car_3wheel", comment: "")
//                }
//            }
//        }

        if (isSelectedVehicle == arrVehicleList[indexPath.row].VehicleTypeID)
        {
            cell.vwColor.layer.borderColor = UIColor.black.cgColor
            cell.vwColor.layer.borderWidth = 1.0
        }else{
            cell.vwColor.layer.borderColor = UIColor.clear.cgColor
//            cell.vwColor.layer.borderWidth = 1.0
        }

        cell.vwColor.alpha = 0.7
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCarDetailVC") as! AddCarDetailVC
        vc.vehicleType = arrVehicleList[indexPath.row].VehicleTypeID
        vc.strVehicleTitle = arrVehicleList[indexPath.row].VehicleType
        isSelectedVehicle = arrVehicleList[indexPath.row].VehicleTypeID
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
extension VehicleTypeVC{
    func callApiForVehicleType()
    {
        ProgressHUD.show()
        arrVehicleList.removeAll()


        var params = [String:Any]()

        let lang_type = UserDefaults.standard.integer(forKey: "langType")
        params = ["LanguageID": "\(lang_type)"]

        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.GetVehicleType)
        if !Connectivity.isConnectedToInternet() {
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }



        Alamofire.request(API.GetVehicleType, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            ProgressHUD.dismiss()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("car detail",json)

                if(json["status"] == "true") {
                    self.tblVehicleList.isHidden = false
                    //                    UserDefaults.standard.setValue(json["data"].intValue, forKey: "IsCarID")

                    //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddPhotoVC") as? AddPhotoVC
                    //                    self.navigationController?.pushViewController(vc!, animated: true)

                    let arrData = json["data"].array
                    for value in arrData! {
                        let pckgDetModel:VehicleModelList = VehicleModelList.init(VehicleTypeID: value["VehicleTypeID"].intValue, VehicleType: value["VehicleType"].stringValue)
                        self.arrVehicleList.append(pckgDetModel)
                    }
                    DispatchQueue.main.async {
                        self.tblVehicleList.reloadData()
                    }

                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    print("The network is not reachable")
                    return
                }
                //  self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                ProgressHUD.dismiss()
                //Bhargav Hide
                self.tblVehicleList.isHidden = true
                self.lblNoDataFound.text = "No Data Found..."
                self.lblNoDataFound.isHidden = false
                print(error)
            }
        }
    }
}
