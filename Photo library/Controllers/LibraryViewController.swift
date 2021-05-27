//
//  LibraryViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 05.05.2021.
//

import UIKit

class LibraryViewController: UIViewController {
    private let fileManager = FileManager.default
    private let defaults = UserDefaults.standard
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Images")
    private  var imagesArray = [UIImage]()
    private var commentsArray = [String]()
    private var index = 0
    private let leftInset: CGFloat = 20
    private let topInset: CGFloat = 0

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        commentTextField.delegate = self
        loadImages()
        checkImageArray()

        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationVC = storyboard.instantiateInitialViewController() else {
            return
        }
        destinationVC.modalTransitionStyle = .coverVertical
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }

    // MARK: - Load saved images methods
    private func loadImages() {
        guard let path = documentsPath?.path else {
            return
        }
        if let imageNames = try? fileManager.contentsOfDirectory(atPath: "\(path)") {
            for imageName in imageNames {
                if let image = UIImage(contentsOfFile: "\(path)/\(imageName)") {
                    imagesArray.append(image)
                }
            }
        }
    }

    private func checkImageArray() {
        if imagesArray.isEmpty {
            commentTextField.isUserInteractionEnabled = false
        }
    }

    // MARK: - NotificationCenter methods
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
}

extension LibraryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let comment = textField.text {
            if textField.text == "" {
                textField.resignFirstResponder()
            } else {
                commentsArray.append(comment)
            }
        }
        defaults.setValue(commentsArray, forKey: "Comments")
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.layer.cornerRadius = 10
        cell.imageView.image = imagesArray[indexPath.item]
        cell.imageView.contentMode = .scaleAspectFill

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 1.5, height: collectionView.bounds.height / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: topInset, left: leftInset, bottom: topInset, right: leftInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
