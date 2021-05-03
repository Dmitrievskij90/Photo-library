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
        let imageData = NSData(data: image.pngData()!)
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docs = paths[0] as NSString
        let uuid = UUID().uuidString + ".png"
        let fullPath = docs.appendingPathComponent(uuid)
        _ = imageData.write(toFile: fullPath, atomically: true)
        return uuid
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
