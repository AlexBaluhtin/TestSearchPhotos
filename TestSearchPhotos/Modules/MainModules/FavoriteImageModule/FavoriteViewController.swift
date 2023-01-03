//
//  FavoriteViewController.swift
//  TestImages
//
//  Created by Alex Balukhtsin on 6.06.22.
//

import UIKit

protocol FavoriteViewControllerLogic: AnyObject {
    func setupTableView()
}

class FavoriteViewController: UITableViewController {
    
    private var presenter = PresenterFavoriteImages()
    private var arrayFavoriteImages: [Response.ViewModelImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.setViewDelegate(delegate: self)
        presenter.showFavoritePhotos()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         arrayFavoriteImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteImageTableViewCell.cellIdentifier,
                                                 for: indexPath) as! FavoriteImageTableViewCell
        let viewModel = arrayFavoriteImages[indexPath.row]
        cell.configure(data: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         52
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = InfoImageViewController()
        info.viewModelImage = arrayFavoriteImages[indexPath.row]
        navigationController?.pushViewController(info, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewControllerLogic {
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(FavoriteImageTableViewCell.self, forCellReuseIdentifier: FavoriteImageTableViewCell.cellIdentifier)
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = .init(top: 8, left: 0, bottom: -8, right: 0)
    }
}

extension FavoriteViewController: PresenterFavoriteImagesDelegate {
    func presenterFavoriteImages(images: [Response.ViewModelImage]) {
        self.arrayFavoriteImages = images
        tableView.reloadData()
    }
    
    func presenterSplashError(error: Error) {
        
    }
}
