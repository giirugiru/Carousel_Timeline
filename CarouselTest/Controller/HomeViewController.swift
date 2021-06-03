//
//  HomeViewController.swift
//  CarouselTest
//
//  Created by Gilang Sinawang on 02/06/21.
//

import UIKit
import AACarousel
import Kingfisher

class HomeViewController: UIViewController {
  
  @IBOutlet weak var carouselView: AACarousel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupCarousel()
  }
  
  fileprivate func setupView(){
    self.navigationItem.title = "Home"
  }
  
  fileprivate func setupCarousel(){
    carouselView.delegate = self
    carouselView.setCarouselData(paths: Constants.ImageURL,  describedTitle: Constants.ImageURL, isAutoScroll: true, timer: 5.0, defaultImage: "")
    carouselView.setCarouselOpaque(layer: true, describedTitle: false, pageIndicator: false)
    carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: .white, describedTitleColor: nil, layerColor: nil)
  }
}

extension HomeViewController: AACarouselDelegate {
  func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
  }
  
  func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
    imageView.kf.setImage(with: URL(string: Constants.ImageURL[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
  }
  
  func downloadImages(_ url: String, _ index: Int) {
    let imageView = UIImageView()
    imageView.kf.setImage(with: URL(string: Constants.ImageURL[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (result) in
      switch result {
      case .success(let value):
        self.carouselView.images[index] = value.image
      case .failure(let error):
        print(error)
      }
    })
  }
}
