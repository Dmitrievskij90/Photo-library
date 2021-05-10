//
//  LibraryViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 05.05.2021.
//

import UIKit

class LibraryViewController: UIViewController {
    private  var imagesArray = [UIImage]()
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let fileManager = FileManager.default
    private var index = 0
    private lazy var imagesPath = documentsPath.appendingPathComponent("Images")

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self
        createImages()
        addSwipeGestureRecognizer()

        imageView.image = imagesArray[index]

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func addSwipeGestureRecognizer() {
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
        swipeGestureLeft.direction = .left
        swipeGestureRight.direction = .right
        view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureRight)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .left:
                index += 1
                checkIndex()
                imageView.transform = CGAffineTransform(translationX: 300, y: 0)
                applyAnimation()
            case .right:
                index -= 1
                checkIndex()
                imageView.transform = CGAffineTransform(translationX: -300, y: 0)
                applyAnimation()
            default:
                break
            }
        }
    }

    private func checkIndex() {
        if index >= imagesArray.count {
            index = 0
        } else if index <= -1 {
            index = imagesArray.count - 1
        }
        upDateUI()
    }

    private func upDateUI() {
        imageView.image = imagesArray[index]
    }

    private func applyAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
            }
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    private func createImages() {
        if let imageNames = try? fileManager.contentsOfDirectory(atPath: "\(imagesPath.path)") {
            for imageName in imageNames {
                if let image = UIImage(contentsOfFile: "\(imagesPath.path)/\(imageName)") {
                    imagesArray.append(image)
                }
            }
        }
    }
}

extension LibraryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
