//
//  PhotoIncreaseViewController.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import UIKit

class PhotoIncreaseViewController: UIViewController {
    @IBOutlet weak var BigPhotoImageView: UIImageView!
    
    //var image: String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BigPhotoImageView.image = image
//        guard let imageUrl = URL(string: image ?? "" ) else { return }
//        guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//            BigPhotoImageView.image = UIImage(data: imageData)
//    print("loollol")
//        print(image)
}
}
