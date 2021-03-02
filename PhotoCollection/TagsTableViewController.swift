//
//  TagsTableViewController.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import UIKit

class TagsTableViewController: UITableViewController {

    var networkService = NetworkService()
    var tags = [Tag]()
    var tagUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.fetchTags{ [weak self] (searchResults) in
            DispatchQueue.main.async {
                self?.tags = searchResults.hottags.tag
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickPhotoCollectionSegue"{
            let tagVC = segue.destination as! SerachCollectionViewController
            let indexPath = tableView.indexPathForSelectedRow!
            tagVC.tagUrl = tags[indexPath.row].content
            print(tagVC.tagUrl)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagIdentifier", for: indexPath)
        
        let tag = tags[indexPath.row]
        
        cell.textLabel?.text = tag.content
        tagUrl = String?(tag.content) ?? "lox"
        
        cell.imageView?.image = UIImage(systemName:"tag")
        
        return cell
    }
}
