//
//  PhotoTagsCollectionViewController.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import UIKit


class PhotoTagsCollectionViewController: UICollectionViewController {
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var networkService = NetworkService()

    var tagUrl : String = ""
    var photos = [PhotoTag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = tagUrl
        
        networkService.fetchGetPhotoTag(searchText: tagUrl ) { [weak self] (searchResults) in
            DispatchQueue.main.async {
                self?.photos = searchResults.photos.photo
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickBigPhotoSegue"{
            let photoVC = segue.destination as! PhotoIncreaseViewController
            let cell = sender as! CollectionCell
            photoVC.image = cell.photoImageView.image
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionCell
        
        let photo = photos[indexPath.row]
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: photo.urlZ) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.photoImageView.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

}

extension PhotoTagsCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = availableWidth / itemsPerRow + 20
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}

