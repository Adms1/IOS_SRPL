//
//  VehicleTypeModel.swift
//  SRPL
//
//  Created by ADMS on 21/09/21.
//

import Foundation

class VehicleModel{
    var status: String
    var data:[VehicleModelList]
    var Msg:String

    init(status: String,data: [VehicleModelList],Msg: String){

        self.status = status
        self.data = data
        self.Msg = Msg

      }

}
class VehicleModelList
{
    var VehicleTypeID: Int
    var VehicleType:String

    init(VehicleTypeID: Int,VehicleType: String){

        self.VehicleTypeID = VehicleTypeID
        self.VehicleType = VehicleType

      }
}
class VehiclePhotoIdList
{
    var VehiclePhotoID: Int
    
    init(VehiclePhotoID: Int){
        self.VehiclePhotoID = VehiclePhotoID
      }
}
