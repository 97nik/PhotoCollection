//
//  PhotoIncreaseViewController.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import UIKit

class PhotoIncreaseViewController: UIViewController {
    @IBOutlet weak var BigPhotoImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BigPhotoImageView.image = image
    }
}
