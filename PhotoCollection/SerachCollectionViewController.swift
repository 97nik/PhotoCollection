//
//  SerachCollectionViewController.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import UIKit


class SerachCollectionViewController: UICollectionViewController {
    
    var networkService = NetworkService()
    
    let searhController = UISearchController(searchResultsController: nil)
    
    private var timer: Timer?
    var photos = [Photo]()
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickBigPhotoSegue"{
            let photoVC = segue.destination as! PhotoIncreaseViewController
            let cell = sender as! SearchCell
//            photoVC.image = cell.bigPhoto
            photoVC.image = cell.photoImageView.image
    
//            print(";;;;;;;;")
//            print(collectionName.album)
        }
    }
    private func setupSearchBar(){
        navigationItem.searchController = searhController
        searhController.searchBar.delegate = self
    }
  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(photos.count)
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
    
        let photo = photos[indexPath.row]
        print("'''''''''")
//        cell.bigPhoto = photo.urlZ
      
        //cell.photoImageView.image =  #imageLiteral(resourceName: "1")
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: photo.urlZ) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }

            DispatchQueue.main.async {
                cell.photoImageView.image = UIImage(data: imageData)
            }
        }
    
        return cell
    }

    
    

}
extension SerachCollectionViewController : UICollectionViewDelegateFlowLayout {
    
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

extension  SerachCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
      
       // guard let cityName = textField?.text else { return }
//        if searchText != "" {
////                self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
//            let searchTexts = searchText.split(separator: " ").joined(separator: "%20")
        
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchPhotos(searchText: searchText) { [weak self] (searchResults) in
                DispatchQueue.main.async {
                    self?.photos = searchResults.photos.photo
//                    print("!!!")
//                    print(self?.photos)
                self?.collectionView.reloadData()
                }
            }
        })
        
}
}
