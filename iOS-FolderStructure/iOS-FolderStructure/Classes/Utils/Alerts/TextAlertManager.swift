//
//  TextAlertManager.swift
//  Bhoozt
//
//  Created by Tharindu Perera on 11/20/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import Foundation
import UIKit

enum AlertType {
    case error, success, warning
}

class TextAlertManager: LIHAlertManager {
    
    static let errorColor = UIColor(red: 200/255, green: 1/255, blue: 2/255, alpha: 0.95)
    static let successColor = UIColor(red: 17.0/255.0, green: 201.0/255.0, blue: 3.0/255.0, alpha: 0.95)
    static let warningColor = UIColor(red: 249/255, green: 187/255, blue: 45/255, alpha: 0.95)
    
    static func getAlert() -> LIHAlert {
        
        let alert = super.getTextAlert(message: Strings.Alerts.defaultFailedMessage)
        alert.alertColor = errorColor
        alert.alertAlpha = 1.0
        alert.autoCloseTimeInterval = 1.5
        alert.isOrientationLocked = true
        alert.hasNavigationBar = false
        return alert
    }
}
