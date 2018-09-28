//
//  ContentDownloader.swift
//  KisanHub
//
//  Created by Nikhil Modi on 8/16/16.
//  Copyright © 2016 Nikhil Modi. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlertOK(title:String,message:String){
        print("show alert \(message)")
        showAlertOk(title: title, message: message,alertAction:nil)
    }
    func showAlertOk(title:String,message:String,alertAction:UIAlertAction?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if alertAction == nil {

            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //           }
            
        }
        else{
            alertController.addAction(alertAction!)
            
        }
        
        if UIApplication.shared.frontmostViewController?.presentedViewController == nil {
            UIApplication.shared.frontmostViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
extension UIApplication {
    
    var frontmostViewController: UIViewController? {
        let window = UIApplication.shared.keyWindow
        var viewController = window!.rootViewController
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        
        return viewController
    }
}
extension String{
    func convertToCSV() -> String{
        var tempString = self;
        var whiteSpaces = "";
        for character in self{
            if character==" "{
                whiteSpaces = whiteSpaces + " "
            }else{
                tempString = tempString.replacingOccurrences(of: whiteSpaces, with: ",")
                whiteSpaces = ""
            }
        }
        var repeatCommas = ""
        for character in tempString{
            if character == ","{
                repeatCommas = repeatCommas + ","
            }
            else if (repeatCommas.count > 1 ){
                tempString =    tempString.replacingOccurrences(of: repeatCommas, with: ",")
                repeatCommas = ""
            }
        }
        tempString = tempString.replacingOccurrences(of: "\n,", with: "\n")
        return tempString;
    }
}
