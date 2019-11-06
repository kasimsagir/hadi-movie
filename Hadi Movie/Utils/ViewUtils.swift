//
//  ViewUtils.swift
//  Hadi Movie
//
//  Created by Kasım on 6.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class ViewUtils {
    
    static func showCustomAlert(withController viewController: UIViewController, _ title: String?, _ message: String?, _ okButtonTitle: String?, _ okButtonAction: ((UIAlertAction) -> Void)?, _ cancelButtonTitle: String?, _ cancelButtonAction: ((UIAlertAction) -> Void)?){
        
        let alertController = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        
        if let title = okButtonTitle {
            let OKAction = UIAlertAction(title: title, style: .default, handler: okButtonAction ?? { (action:UIAlertAction!) in
                alertController.dismiss(animated: true, completion: nil)
                })
            alertController.addAction(OKAction)
        }
        if let title = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: title, style: .cancel, handler: cancelButtonAction ?? { (action:UIAlertAction!) in
                alertController.dismiss(animated: true, completion: nil)
                })
            alertController.addAction(cancelAction)
        }
        
        viewController.present(alertController, animated: true, completion:nil)
    }
    
    static func showAlert(withController viewController: UIViewController, title: String, message: String?){
        
        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        viewController.present(alertController, animated: true, completion:nil)
    }
    
    static func showTryAgainAlert(withController: UIViewController, title: String, message: String, isCancelable: Bool, repeatAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isCancelable {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        let OKAction = UIAlertAction(title: "Repeat", style: .default, handler: repeatAction)
        alertController.addAction(OKAction)
        
        withController.present(alertController, animated: true, completion:nil)
    }
    
    static func showAlertAndDismissController(withController viewController: UIViewController, title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
            viewController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        viewController.present(alertController, animated: true, completion:nil)
    }
    
    static func showTableViewEmptyLabel(tableView: UITableView, message: String, containerView: UIView) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }
    
    static func hideTableViewEmptyMessage(tableView: UITableView) {
        tableView.backgroundView = UIView()
    }
    
}
