//
//  Validation+String.swift
//  rgApp
//
//  Created by ADMS on 03/08/21.
//

import Foundation

extension String {
    var isValidContact: Bool {
//        let phoneNumberRegex = "^[6-9]\\d{9}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
//        let isValidPhone = phoneTest.evaluate(with: self)
//        return isValidPhone

//        let regex = try! NSRegularExpression(pattern: "^[6-9]\\d{9}$", options: .caseInsensitive)
//        let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//        print("Mobile validation \(valid)")
//          return valid

        let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"

        let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return phoneCheck.evaluate(with: self)


    }
//    func isValidPhone() -> Bool {
//
//          }
}

