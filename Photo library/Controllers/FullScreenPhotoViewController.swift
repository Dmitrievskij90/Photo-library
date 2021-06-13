//
//  FullScreenPhotoViewController.swift
//  Photo library
//
//  Created by Konstantin Dmitrievskiy on 28.05.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    @IBOutlet weak var fullImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
