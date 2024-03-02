//
//  UIViewController+Ext.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit.UIViewController

extension UIViewController {
    
    func presentAlertOnMainThread(
        title: String,
        message: String,
        buttonTitle: String
    ) {
        DispatchQueue.main.async {
            let alertController = AlertManager.createAlertController(
                title: title,
                message: message,
                buttonTitle: buttonTitle
            )
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
