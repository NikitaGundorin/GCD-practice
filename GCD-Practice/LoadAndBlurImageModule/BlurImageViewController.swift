//
//  BlurImageViewController.swift
//  GCD-Practice
//
//  Created by Никита Гундорин on 23.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit

class BlurImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadImage()
        }
    }
    
    func loadImage() {
        guard let url = URL(string: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-11-pro-select-2019-family_GEO_EMEA"),
            let data = (try? Data(contentsOf: url)),
            let image = self.addBlurTo(image: UIImage(data: data))
        else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                let alertController = UIAlertController(title: "Error", message:
                    "Error while loading image", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func addBlurTo(image: UIImage?) -> UIImage? {
        guard let image = image,
            let ciImg = CIImage(image: image)
            else { return nil }
        let blur = CIFilter(name: "CIGaussianBlur")
        blur?.setValue(ciImg, forKey: kCIInputImageKey)
        blur?.setValue(5.0, forKey: kCIInputRadiusKey)
        if let outputImg = blur?.outputImage {
            return UIImage(ciImage: outputImg)
        }
        return nil
    }
}
