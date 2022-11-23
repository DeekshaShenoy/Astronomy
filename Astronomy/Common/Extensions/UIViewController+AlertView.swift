//
//  UIViewController+AlertView.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import UIKit

struct AlertInfo {
    var title: String?
    var message: String?
    var options: [AlertDetails]?
}

struct AlertDetails {
    var title: String?
    var style: UIAlertAction.Style = .default
    var accessibilityLabel: String?
    var isPreferredAction: Bool = false
    var completion: (() -> Void)?
}

extension UIViewController {

    func presentAlertWith(alertInfo: AlertInfo) {
        let alertController = UIAlertController(title: alertInfo.title, message: alertInfo.message, preferredStyle: .alert)
        
        for option in alertInfo.options ??  [] {
            let alertAction = UIAlertAction(title: option.title, style: option.style, handler: { _ in
                option.completion?()
            })
            alertAction.accessibilityLabel = option.accessibilityLabel
            alertController.addAction(alertAction)
            if option.isPreferredAction && alertController.preferredAction == nil {
                alertController.preferredAction = alertAction
            }
        }
        present(alertController, animated: true, completion: nil)
    }
}
