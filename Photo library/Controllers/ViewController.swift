//
//  ViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    private let fileManager = FileManager.default
    private let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("Images")
    private lazy var dateFormatter = DateFormatter()
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
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

    private func displayImagePickerController() {
        let imagePicerController = UIImagePickerController()
        imagePicerController.delegate = self
        imagePicerController.sourceType = .photoLibrary
        present(imagePicerController, animated: true, completion: nil)
    }

    private func configureDirectory() {
        if let path = documentsPath {
            try? fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
        }
    }

    private func getCurrentDate(_ dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        let dataString = dateFormatter.string(from: Date())
        return dataString
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let path = documentsPath?.path else {
            fatalError("Can't find document path")
        }
        if let image = info [.originalImage] as? UIImage {
            if fileManager.fileExists(atPath: path) == false {
                do {
                    try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    fatalError("Can't save image to directory")
                }
            }
            let data = image.jpegData(compressionQuality: 0.5)
            let imageName = "\(getCurrentDate("yyyy MMM dd HH:mm:ss")).png"
            fileManager.createFile(atPath: "\(path)/\(imageName)", contents: data, attributes: nil)
        } else {
            fatalError("Can't find image")
        }
        dismiss(animated: true, completion: nil)
    }
}
