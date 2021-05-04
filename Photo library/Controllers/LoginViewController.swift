//
//  LoginViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private let userlogin = "Konstantin"
    private let userPassword = "20051990"

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction private func verifyButtonPressed(_ sender: Any) {
        validateCredentials()
    }

    @IBAction private func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    private func validateCredentials() {
        guard let login = loginTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }

        if login == userlogin, password == userPassword {
            let viewController = LibraryViewController.instantiate()
            //            viewController.modalTransitionStyle = .coverVertical
            //            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        } else {
            presentOneButtonAlert(withTitle: "Error", message: "Wrong user data. Please try again")
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
}
