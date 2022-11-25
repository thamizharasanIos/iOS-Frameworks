
import Foundation
import UIKit


extension String{
    var removeWhiteSpace: String{
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return str
    }

    var isValidMobileNumber: Bool{
        let count = self.removeWhiteSpace.count
        return (count >= 6 && count <= 13)
    }
    
    var isValidCountryCode: Bool{
        let count = self.removeWhiteSpace.count
        return count >= 2 && count <= 4 //&& count <= 12
    }
    var isValidOTP: Bool{
        let count = self.removeWhiteSpace.count
        return count == 4 //&& count <= 12
    }
    var isValidUserName: Bool{
        let count = self.removeWhiteSpace.count
        return count >= 3 && count <= 30
    }
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidPassword: Bool{
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var hasOneUpperCaseAndOneLowerCase:Bool{
        let upperCaseRegEx  = ".*[A-Z]+.*"
        guard NSPredicate(format:"SELF MATCHES %@", upperCaseRegEx).evaluate(with: self) else { return false }
        let lowerCaseRegEx  = ".*[a-z]+.*"
        guard NSPredicate(format:"SELF MATCHES %@", lowerCaseRegEx).evaluate(with: self) else { return false }
        return true
    }
    
    var hasOneNumber:Bool{
        let numbersRegEx  = ".*[0-9]+.*"
        return NSPredicate(format:"SELF MATCHES %@", numbersRegEx).evaluate(with: self)
    }
    
    var hasOneSpecialCharecter:Bool{
        let specialCharecterRegEx  = ".*[!-/:-@\\[-`{-~]+.*"
        return NSPredicate(format:"SELF MATCHES %@", specialCharecterRegEx).evaluate(with: self)
    }
}
