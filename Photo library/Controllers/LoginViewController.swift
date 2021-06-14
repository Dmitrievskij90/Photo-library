//
//  LoginViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import KeychainAccess
import UIKit

class LoginViewController: UIViewController {
    private let keychain = Keychain()

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
            fatalError("Wrong login")
        }
        guard let password = passwordTextField.text else {
            fatalError("Wrong password")
        }

        if KeychainManager.shared.userLogin == login, KeychainManager.shared.userPassword == password {
            let viewController = LibraryViewController.instantiate()
            viewController.modalTransitionStyle = .coverVertical
            viewController.modalPresentationStyle = .fullScreen
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
