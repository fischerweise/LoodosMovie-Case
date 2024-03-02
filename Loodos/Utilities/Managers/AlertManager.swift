//
//  AlertManager.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit.UIAlertController

enum AlertManager {
    
    static func createAlertController(
        title: String,
        message: String,
        buttonTitle: String?
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.modalPresentationStyle = .overFullScreen
        alertController.modalTransitionStyle = .crossDissolve

        if let buttonTitle = buttonTitle {
            let okAction = UIAlertAction(
                title: buttonTitle,
                style: .default,
                handler: nil
            )
            alertController.addAction(okAction)
        }

        return alertController
    }
}
