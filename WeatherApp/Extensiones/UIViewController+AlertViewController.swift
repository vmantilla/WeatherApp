//
//  UIViewController+AlertViewController.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 30/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlertWithRetryCancel(
        title: String,
        message: String,
        retryHandler: @escaping () -> Void,
        cancelHandler: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: NSLocalizedString("retry", comment: ""), style: .default) { _ in
            retryHandler()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel) { _ in
            cancelHandler()
        }
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
