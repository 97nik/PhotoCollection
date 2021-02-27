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
   // var lol = "\(tagUrl)"
    var photos = [PhotoTag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   guard  let lol = "\(String(describing: tagUrl))" else { return }
        navigationItem.title = tagUrl
        print("lalalalal")
        print(tagUrl)
        print(tagUrl)
        
        networkService.fetchGetPhotoTag(searchText: tagUrl ) { [weak self] (searchResults) in
            DispatchQueue.main.async {
                self?.photos = searchResults.photos.photo
//                    print("zzzzzzzzz")
//                    print(self?.photos)
            self?.collectionView.reloadData()
            }
        }
            

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickBigPhotoSegue"{
            let photoVC = segue.destination as! PhotoIncreaseViewController
            let cell = sender as! CollectionCell
//            photoVC.image = cell.bigPhoto
            photoVC.image = cell.photoImageView.image
    
//            print(";;;;;;;;")
//            print(collectionName.album)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        print("photos.count")
//        print(photos.count)
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionCell
    
        let photo = photos[indexPath.row]
     //   print("'''''''''")
//        cell.bigPhoto = photo.urlZ
      
    //    cell.photoImageView.image =  #imageLiteral(resourceName: "2")
        
        
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

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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

