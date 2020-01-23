//
//  MasterTableViewController.swift
//  LastFm
//
//  Created by Josue Arambula on 1/21/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

import UIKit

protocol AlbumSelectionDelegate: class {
    func albumSelected(_ newAlbum: AlbumObjects)
}

class MasterTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    weak var delegate: AlbumSelectionDelegate?
    var albumsArray : [AlbumObjects] = []
    var imagesUrlArray: [ImageArray] = []
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    
    
    func getOneAlbum(){
        let artistName = "believe" // for testing
        ApiRequest.getAlbums(query: artistName) { (albumsDetails, error) in
            // no error or error is empty
            if (error == nil) {
                if let albumsArray = albumsDetails?.albummatches {
                    if let firstAlbum = albumsArray.album.first {
                        self.delegate?.albumSelected(firstAlbum)
                    }
                }
            }
        }// fin de la llamada
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplit()
        getAlbumList()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
        return self.albumsArray.count
    }
    
    private func setupSplit(){
        splitViewController?.delegate = self //as? UISplitViewControllerDelegate
        splitViewController!.preferredDisplayMode = UISplitViewController.DisplayMode.primaryOverlay
        splitViewController!.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    private func getAlbumList(){
        // clear the arrays before us it
        self.albumsArray = []
        self.imagesUrlArray = []
        let artistName = "believe" // for testing
        ApiRequest.getAlbums(query: artistName) { (albumsDetails, error) in
            // no error or error is empty
            if (error == nil) {
                if let albumsArray = albumsDetails?.albummatches {
                    for singleAlbum in albumsArray.album {
                        self.albumsArray.append(singleAlbum)
                    }
                    //                    print("asi quedo 1: \(self.albumsArray.count)")
                    //                    print(self.albumsArray)
                    if let firstAlbum = albumsArray.album.first {
                        self.delegate?.albumSelected(firstAlbum)
                    }
                }
                // load the collectionView
                DispatchQueue.main.async{ self.tableView.reloadData() }
            }
        }// fin de la llamada
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        // this is just the name in the table view rows
        let album = self.albumsArray[indexPath.row]
        cell.textLabel?.text = album.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = self.albumsArray[indexPath.row]
        delegate?.albumSelected(selectedAlbum)
        if let detailViewController = delegate as? DetailViewController, let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
