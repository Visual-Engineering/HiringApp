//
//  Utils.swift
//  HiringApp
//
//  Created by Alba Luján on 30/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation

func showAlert(baseView: UIViewController, title: String, message: String, actions: [UIAlertAction]?) {
    
    /* Shows an alert view with custom actions */
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for action in actions! {
        alertController.addAction(action)
    }
    baseView.present(alertController, animated: true, completion: nil)
}


func showAlert(baseView: UIViewController, title: String, message: String) {
    
    /* Shows an alert view with default action */
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    baseView.present(alertController, animated: true, completion: nil)
}
