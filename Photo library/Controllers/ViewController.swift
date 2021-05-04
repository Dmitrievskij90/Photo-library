//
//  ViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let fileManager = FileManager.default
    private lazy var imagesPath = documentsPath.appendingPathComponent("Images")

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDirectory()
    }

    @IBAction private func addButtonPressed(_ sender: UIButton) {
        displayImagePickerController()
    }

    @IBAction private func showButtonPressed(_ sender: UIButton) {
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

    private func configureDirectory() {
        try? fileManager.createDirectory(at: imagesPath, withIntermediateDirectories: true, attributes: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info [.originalImage] as? UIImage {
            if fileManager.fileExists(atPath: imagesPath.path) == false {
                do {
                    try fileManager.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    fatalError("Can't save image to directory")
                }
            }
            let data = image.jpegData(compressionQuality: 0.7)
            let imageName = "\(Date().timeIntervalSince1970).png"
            let folderPath = "\(imagesPath.path)"
            if fileManager.createFile(atPath: "\(folderPath)/\(imageName)", contents: data, attributes: nil) {
            }
            dismiss(animated: true, completion: nil)
        }
    }
}
