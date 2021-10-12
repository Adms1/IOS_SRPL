//
//  VehicleCell.swift
//  SRPL
//
//  Created by ADMS on 21/09/21.
//

import UIKit

class VehicleCell: UITableViewCell {

    @IBOutlet var lblVehicleType: UILabel!
    @IBOutlet var vwColor: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
