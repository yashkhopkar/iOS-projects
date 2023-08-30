//
//  FavouritesDetailsViewController.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-08-12.
//

import UIKit

class FavouritesDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var favDetailsScrollView: UIScrollView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var gameName: String?
    var gameURL: URL?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = gameName
        if let imageURL = gameURL {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }.resume()
        }
        
        favDetailsScrollView.delegate = self
        favDetailsScrollView.minimumZoomScale = 1.0
        favDetailsScrollView.maximumZoomScale = 4.0
        
        configureDoubleTapGesture()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func configureDoubleTapGesture() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(doubleTap)
    }

    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if favDetailsScrollView.zoomScale == 1 {
            favDetailsScrollView.zoom(to: zoomRectForScale(scale: favDetailsScrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            favDetailsScrollView.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = image.frame.size.height / scale
        zoomRect.size.width  = image.frame.size.width  / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
