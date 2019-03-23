//
//  Utils.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation
import UIKit

class Utils {    
    static func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("keyWindow has no rootViewController")
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func doesAlertViewExist() -> Bool {        
        return !(UIApplication.shared.keyWindow?.isMember(of: UIWindow.layerClass))!
    }
}
