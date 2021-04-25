//
//  ViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    var photoArray = [UIImage]()
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func addButtonPressed(_ sender: UIButton) {
        displayImagePickerController()
    }

    @IBAction private func showButtonPressed(_ sender: UIButton) {
        // print(photoArray)
        let viewController = LoginViewController.instantiate()
        // viewController.modalTransitionStyle = .coverVertical
        // viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

    private func displayImagePickerController() {
        let imagePicerController = UIImagePickerController()
        imagePicerController.delegate = self
        imagePicerController.sourceType = .photoLibrary
        //imagePicerController.allowsEditing = true
        present(imagePicerController, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            photoArray.append(pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
