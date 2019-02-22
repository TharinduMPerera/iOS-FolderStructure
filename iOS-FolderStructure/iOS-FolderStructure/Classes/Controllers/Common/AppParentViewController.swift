//
//  AppParentViewController.swift
//  iOS-FolderStructure
//
//  Created by Tharindu Perera on 2/22/19.
//  Copyright © 2019 Tharindu Perera. All rights reserved.
//

import UIKit

class AppParentViewController: UIViewController {
    
    fileprivate var alert: LIHAlert?
    
    //////////////////////////////////////////////////////
    //MARK: - View Controller Methods
    //////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //////////////////////////////////////////////////////
    //MARK: - Public Methods
    //////////////////////////////////////////////////////
    
    func initAlerts(containerView: UIView) {
        
        alert = TextAlertManager.getAlert()
        alert?.initAlert(containerView)
    }
    
    func showAlert(message: String, type: AlertType, showed: (() -> Void)?, hidden: (() -> Void)?) {
        
        if type == AlertType.success {
            alert?.alertColor = TextAlertManager.successColor
        } else if type == AlertType.error {
            alert?.alertColor = TextAlertManager.errorColor
        } else if type == AlertType.warning {
            alert?.alertColor = TextAlertManager.warningColor
        }
        
        alert?.contentText = message
        alert?.show(showed, hidden: hidden)
    }
    
    //////////////////////////////////////////////////////
    //MARK: - Private Methods
    //////////////////////////////////////////////////////
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
    }
    
    //////////////////////////////////////////////////////
    //MARK: - Events
    //////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////
    //MARK: - Delegate Methods
    //////////////////////////////////////////////////////

}
