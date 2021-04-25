//
//  ViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    var photoArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func displayImagePickerController() {
        let imagePicerController = UIImagePickerController()
        imagePicerController.delegate = self
        imagePicerController.sourceType = .photoLibrary
//        imagePicerController.allowsEditing = true
        present(imagePicerController, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        displayImagePickerController()
    }


    @IBAction func showButtonPressed(_ sender: UIButton) {
        print(photoArray)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[.originalImage] as? UIImage {
            photoArray.append(pickedImage)
            }
            dismiss(animated: true, completion: nil)
    }
}

