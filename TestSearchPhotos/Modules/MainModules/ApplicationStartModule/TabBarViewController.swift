//
//  TabBarViewController.swift
//  TestImages
//
//  Created by Alex Balukhtsin on 5.06.22.
//

import UIKit

protocol TabBarLogic: AnyObject {
  func initialViewControllers()
  func createNavigationViewController(rootViewController: UIViewController,
                                      title: String,
                                      image: UIImage) -> UIViewController
}

final class TabBarViewController: UITabBarController {
  
  private var imagesController = ModulBuilder.createImagesModule(flowLayout: UICollectionViewFlowLayout())
  private var favoriteImageController = ModulBuilder.createFavoriteImagesModule()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTabBar()
    initialViewControllers()
  }
  
  func setupTabBar() {
    tabBar.backgroundColor = .white
    tabBar.tintColor = .red
    tabBar.isTranslucent = false
    tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
    tabBar.layer.shadowRadius = 10
    tabBar.layer.shadowColor = #colorLiteral(red: 0.958, green: 0.958, blue: 0.958, alpha: 1).cgColor
    tabBar.layer.shadowOpacity = 1
  }
}

extension TabBarViewController: TabBarLogic {
  func createNavigationViewController(rootViewController: UIViewController,
                                      title: String,
                                      image: UIImage) -> UIViewController {
    let navVC = UINavigationController(rootViewController: rootViewController)
    navVC.tabBarItem.title = title
    navVC.tabBarItem.image = image
    return navVC
  }
  
  func initialViewControllers() {
    viewControllers = [
      createNavigationViewController(rootViewController: imagesController,
                                     title: "Картинки", image: UIImage(systemName: "folder") ?? UIImage()),
      createNavigationViewController(rootViewController: favoriteImageController,
                                     title: "Избранные", image: UIImage(systemName: "star") ?? UIImage())
    ]
  }
}
