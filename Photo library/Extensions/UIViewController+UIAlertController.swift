//
//  UIViewController+UIAlertController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 04.05.2021.
//

import UIKit

extension UIViewController {
    func presentOneButtonAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func presentTwoButtonAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func presentRegisterAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let registerAction = UIAlertAction(title: "Register", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            let viewController = RegisterViewController.instantiate()
            viewController.modalTransitionStyle = .coverVertical
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: "Sign in", style: .destructive) { _ in
            alertController.dismiss(animated: true, completion: nil)
            let viewController = LoginViewController.instantiate()
            viewController.modalTransitionStyle = .coverVertical
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
        alertController.addAction(registerAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            alertController.view.superview?.isUserInteractionEnabled = true
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        }
    }
    @objc func dismissOnTapOutside() {
        self.dismiss(animated: true, completion: nil)
    }
}
