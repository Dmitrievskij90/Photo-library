//
//  RegisterViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 14.06.2021.
//

import KeychainAccess
import UIKit

class RegisterViewController: UIViewController {
    private let keychain = Keychain()
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func registerButtonPressed(_ sender: Any) {
        setUserData()
    }

    private func setUserData() {
        guard let login = loginTextField.text else {
            fatalError("Wrong login")
        }
        guard let password = passwordTextField.text else {
            fatalError("Wrong password")
        }

        if login.isEmpty || password.isEmpty {
            presentOneButtonAlert(withTitle: "Empty field", message: "Please enter user data")
        } else {
            KeychainManager.shared.setUserCredentials(login: login, password: password)
            presentLibraryViewController()
        }
    }

    private func presentLibraryViewController() {
        let viewController = LibraryViewController.instantiate()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
