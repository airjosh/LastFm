//
//  DetailViewController.swift
//  LastFm
//
//  Created by Josue Arambula on 1/21/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

import UIKit
import WebKit


class DetailViewController: UIViewController {
    
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playerView: WKWebView!
    
    let albumImageCache = NSCache<AnyObject, AnyObject>()
    var videoPlayer: String?
    
    var album: AlbumObjects? {
        didSet{
            refreshUI()            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    private func refreshUI(){
        DispatchQueue.main.async {
            self.loadViewIfNeeded()
            self.albumLabel.text = self.album?.name
            self.videoPlayer = self.album?.url
            self.artistLabel.text = self.album?.artist
            if let url = URL(string:self.videoPlayer ?? ""){
                self.playerView.load(URLRequest(url: url))
            }
            
            
            if let images = self.album?.image {
                for iconImage in images {
                    let thumbNailUrl : String?
                    // just happens once
                    if (self.getDeviceSize() == iconImage.size) {
                        thumbNailUrl = iconImage.text
                    } else {
                        // go to the next object in the array
                        continue
                    }
                    // is the image cached
                    guard let thumbNail = thumbNailUrl else { return }
                    if let imageFromCache = self.albumImageCache.object(forKey: thumbNail as AnyObject) as? UIImage {
                        self.iconImageView.image = imageFromCache
                        // the image has set
                        return
                    }
                    
                    
                    
                    let data = try? Data(contentsOf: URL(string: thumbNail)!)
                    if let data = data, let imageToCache = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.albumImageCache.setObject(imageToCache, forKey: thumbNail as AnyObject)
                            // presenting images by a simple animation
                            UIView.animate(withDuration: 1, delay: 1, options: UIView.AnimationOptions(), animations: {
                                self.iconImageView.image = imageToCache
                            }, completion: nil)
                        }
                    }
                    
                    break
                }// for end
            }// if let end
        }// end dispatch
    }// func end
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



// MARK: - Extensions

extension DetailViewController: AlbumSelectionDelegate {
    func albumSelected(_ newAlbum: AlbumObjects) {
        album = newAlbum
    }
}

extension UITraitEnvironment{
    func getDeviceSize() -> String {
        switch traitCollection.preferredContentSizeCategory {
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .extraLarge:
            return "extraLarge"
        default:
            return "unknown"
        }
    }
}

