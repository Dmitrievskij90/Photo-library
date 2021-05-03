//
//  ViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    var photoArray = [UIImage]()
    var photoName = [String]()
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //        print(path)
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
        // imagePicerController.allowsEditing = true
        present(imagePicerController, animated: true, completion: nil)
    }

    func saveImage(image: UIImage) -> String {
        let uuid = UUID().uuidString + ".jpeg"
        if let data = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent(uuid)
            try? data.write(to: filename)
        }
        return uuid
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            saveImage(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
