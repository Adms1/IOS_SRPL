//
//  AddPhotoVC.swift
//  SRPL
//
//  Created by ADMS on 15/09/21.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import ProgressHUD
import Toast_Swift


class AddPhotoVC: UIViewController {

    @IBOutlet weak var imgCollectionView:UICollectionView!
    var picker = UIImagePickerController()
    @IBOutlet weak var btnCamera:UIButton!

    @IBOutlet weak var btnQuote:UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblTitle: UILabel!

    @IBOutlet var btnPopOk: UIButton!
    @IBOutlet var vwPopUp: UIView!
    @IBOutlet var vwSubPopUp: UIView!
    @IBOutlet var imagePopUp: UIImageView!
    @IBOutlet var lblPopUpTitle: UILabel!
    var selectPhotoIndex:Int = 0
    var deletePhotoIndex:Int = 0


    var uploadStringName:String = ""



    var arrVehiclePhotoIdList = [VehiclePhotoIdList]()

    var arr_Item = [UIImage]()
    var image_name:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Add Photos"
//        self.imagePopUp.bringSubviewToFront(self.vwSubPopUp)

        self.vwSubPopUp.layer.cornerRadius = 6.0
        self.vwSubPopUp.layer.masksToBounds = true

        self.navigationController?.navigationBar.isHidden = true

        lblTitle.text = NSLocalizedString("srpl_Add Photos", comment: "")
        btnBack.setTitle(NSLocalizedString("srpl_Back", comment: ""), for: .normal)
        btnPopOk.setTitle(NSLocalizedString("srpl_ok", comment: ""), for: .normal)
        lblPopUpTitle.text = NSLocalizedString("srpl_PopUp_title", comment: "")


        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let width  = (view.frame.width-40)/3

        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        imgCollectionView!.collectionViewLayout = layout

        imgCollectionView.isScrollEnabled = false

        btnCamera.layer.cornerRadius = 6.0
        btnCamera.layer.masksToBounds=true

        btnCamera.layer.borderColor = UIColor.black.cgColor
        btnCamera.layer.borderWidth = 5.0
    }
    @IBAction func btnBackClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClickPopClose()
    {
        self.vwPopUp.isHidden = true
    }
    @IBAction func btnClickCamera(_sender:UIButton)
    {
        // vwImgCollection.isHidden = false

        //        if arr_Item.count == 1
        //        {
        //
        //        }else{
        let alert:UIAlertController=UIAlertController(title: NSLocalizedString("srpl_validation16", comment: ""), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: NSLocalizedString("srpl_camera", comment: ""), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
//        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
//        {
//            UIAlertAction in
//            self.openGallary()
//        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("srpl_cancel", comment: ""), style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
//        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

        //  }
    }


    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        else
        {
            // Create the alert controller
            let alertController = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)

            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                //  NSLog("OK Pressed")
            }


            // Add the actions
            alertController.addAction(okAction)

            // Present the controller
            self.present(alertController, animated: true, completion: nil)


        }
    }

    func openGallary()
    {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }

    @IBAction func btnClickPopUp(_sender:UIButton)
    {
        self.vwPopUp.isHidden = true
        for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: SelectLanguageVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                }
        }
    }
    
    @IBAction func btnClickQuote(_sender:UIButton)
    {
        if arr_Item.count == 0
        {
            self.view.makeToast(NSLocalizedString("srpl_add_image_validation", comment: ""))
        }else{
            self.vwPopUp.isHidden = false
        }
        //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddPhotoVC") as? AddPhotoVC
        //                    self.navigationController?.pushViewController(vc!, animated: true)
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
extension AddPhotoVC:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        //        self.btnCamera.isEnabled = false
        //        vwImgCollection.isHidden = false
        selectPhotoIndex = selectPhotoIndex + 1
        let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        arr_Item.append(pickedImage)
        uploadPhotoes()
        DispatchQueue.main.async {
            self.imgCollectionView.reloadData()
        }


        //        if let pickedImage1 = info[UIImagePickerController.InfoKey.imageURL] as? URL {
        //                           arr_Item.append(pickedImage1)
        //                           vwImgCollection.isHidden = false
        //                           DispatchQueue.main.async {
        //                               self.imgCollectionView.reloadData()
        //                           }
        //                       }


        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
extension AddPhotoVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //return CGSize(width: 100, height: 100);
        let width  = (view.frame.width-40)/3
        return CGSize(width: width, height: width)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Item.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as! imageCollectionCell
        //  cell.imgComment.sd_setImage(with:arr_Item[indexPath.row])
        cell.sizeToFit()
        cell.imgComment.image = arr_Item[indexPath.row]
        //  cell.imgComment.contentMode = .scaleAspectFit
        // cell.btnImageDelete.isHidden = false


        cell.imgComment.layer.cornerRadius = 5
        cell.imgComment.layer.masksToBounds = true
        cell.btnDeleteImage.tag = indexPath.row
        cell.btnDeleteImage.addTarget(self, action: #selector(imagecommentBtnClick), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 10, left: 0, bottom: 10, right: 0)
    }
    @objc func imagecommentBtnClick(sender:UIButton){

        if (arr_Item.count != 0) {
            arr_Item.remove(at: sender.tag)
            selectPhotoIndex = selectPhotoIndex - 1
            deletePhotoIndex = arrVehiclePhotoIdList[sender.tag].VehiclePhotoID
            print("VehiclePhotoID",arrVehiclePhotoIdList[sender.tag].VehiclePhotoID)
            arrVehiclePhotoIdList.remove(at: sender.tag)
            deletUploadPhotoes(deletePhotoID: deletePhotoIndex)

        }
    }

}
extension AddPhotoVC
{

    func uploadPhotoes()
    {

        ProgressHUD.show()


        let image:UIImage = self.arr_Item[selectPhotoIndex-1]
        //  let imagesData = image.jpegData(compressionQuality: 0.4)!
        let imagesData = image.pngData()!


        let urlString = API.uploadImageUrl
        let date :NSDate = NSDate()
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        self.image_name = "iOS_\(dateFormatter.string(from: date as Date)).png"
        uploadStringName = self.image_name
        var parameters = [String:Any]()

        let cusId = UserDefaults.standard.integer(forKey: "IsCustomerId")
        let carId = UserDefaults.standard.integer(forKey: "IsCarID")

        parameters = ["CustomerID": "\(cusId)","VehiclePhotosID": "\(carId)","ImagetName":"\(self.image_name)"]

        

        Alamofire.upload(multipartFormData: { multipartFormData in

                multipartFormData.append(imagesData, withName: "files", fileName: self.image_name, mimeType: "image/png")
            print(multipartFormData)
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: urlString,

        encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON{ response in
                    ProgressHUD.dismiss()
                    print("data value__:",response.result.value as Any)

                    print("Succesfully uploaded  = \(response)")

//                    self.view.makeToast("Image upload successfully.")

                    self.uploadPhotoDataInsert()

//                    for controller in self.navigationController!.viewControllers as Array {
//                        if controller.isKind(of: PersonalDetailVC.self) {
//                            self.navigationController!.popToViewController(controller, animated: true)
//                            break
//                        }
//                    }
                }
            case .failure(let error):
                ProgressHUD.dismiss()
                print(error)
            }
        })

    }

    func uploadPhotoDataInsert()
    {

        ProgressHUD.show()
        self.arrVehiclePhotoIdList.removeAll()

        var parameters = [String:Any]()

        let cusId = UserDefaults.standard.integer(forKey: "IsCustomerId")
        let carId = UserDefaults.standard.integer(forKey: "IsCarID")

        parameters = ["CustomerID": "\(cusId)","VehicleDetailID": "\(carId)","ImagetName":"\(self.image_name)"]

        print("parameters>>>",parameters)

        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.AddVehiclePhoto)
        if !Connectivity.isConnectedToInternet() {
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }



        Alamofire.request(API.AddVehiclePhoto, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            ProgressHUD.dismiss()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("car detail",json)

                if(json["status"] == "true") {

                    let arrData = json["data"].array
                    for value in arrData! {
                        let pckgDetModel:VehiclePhotoIdList = VehiclePhotoIdList.init(VehiclePhotoID: value["VehiclePhotoID"].intValue)
                        self.arrVehiclePhotoIdList.append(pckgDetModel)
//                        self.arrVehiclePhotoIdList.reversed()
                    }
                    self.view.makeToast(NSLocalizedString("srpl_validation13", comment: ""))
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

    func deletUploadPhotoes(deletePhotoID:Int)
    {

        ProgressHUD.show()

        var parameters = [String:Any]()

        parameters = ["VehiclePhotosID": "\(deletePhotoID)"]

        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // Hide
        print("API, Params: \n",API.DeleteVehiclephoto)
        if !Connectivity.isConnectedToInternet() {
            //  self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }



        Alamofire.request(API.DeleteVehiclephoto, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            ProgressHUD.dismiss()

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Bhargav Hide
                print("car detail",json)

                if(json["status"] == "true") {
                    self.view.makeToast(NSLocalizedString("srpl_validation14", comment: ""))
                    DispatchQueue.main.async {
                        self.imgCollectionView.reloadData()
                    }

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

