//
//  Alert.swift
//  ShortDistanceRoute
//
//  Created by Saadet Şimşek on 04/08/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void){
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK",
                                    style: .default) { (action) in
            let textfieldText = alertController.textFields?.first
            guard let text = textfieldText?.text else{
                return
            }
            completionHandler(text)
            print("action")
            
        }
        
        alertController.addTextField { tf in
            tf.placeholder = placeholder
            
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default){ (_) in
            
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func AlertError(title: String, message: String){
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK",
                                    style: .default)
        alertController.addAction(alertOK)
        present(alertController, animated: true)
    }
}
