//
//  ImagesViewController.swift
//  TestImages
//
//  Created by Alex Balukhtsin on 6.06.22.
//

import UIKit

protocol ImagesViewLogic: AnyObject {
    func setupCollectionViewLayout()
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout
    func setupNavigationBar()
}

class ImagesViewController: UICollectionViewController {
    var presenter: PresenterImagesProtocol!
    
    private let refreshControl = UIRefreshControl()
    private var arrayImages: [Response.ViewModelImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Это нужно, что бы при первом открытии загаловок оставался large
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
        setupCollectionViewLayout()
        setupNavigationBar()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        ImageCollectionViewCell.identifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        let viewModel = arrayImages[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InfoImageViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.viewModelImage = arrayImages[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ImagesViewController: ImagesViewLogic {
    
    func setupNavigationBar() {
        title = "Images"
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.delegate = self
        let textFieldInsideSearchBar = navigationItem.searchController?.searchBar.value(forKey: "searchField") as? UITextField

        textFieldInsideSearchBar?.textColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupCollectionViewLayout() {
         collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.showsVerticalScrollIndicator = false
         collectionView.collectionViewLayout = getCompositionalLayout()
         collectionView.backgroundColor = .white
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
         collectionView.refreshControl = refreshControl
     }
    
    func createItemSizeForCollectionView() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1),
                heightDimension:
                        .fractionalWidth(1 / 2)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 0,
            trailing: 16)
        return item
    }
    
    func createGroup1Item1CollectionView() -> NSCollectionLayoutItem {
        let group1Item1 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1 / 2),
                heightDimension:
                        .fractionalWidth(1)))
        group1Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 0,
            trailing: 8)
        return group1Item1
    }
    
    func createNestedGroup1Item1CollectionView() -> NSCollectionLayoutItem {
        let nestedGroup1Item1 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1),
                heightDimension:
                        .fractionalWidth(1)))
        nestedGroup1Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 0,
            bottom: 8,
            trailing: 16)
        return nestedGroup1Item1
    }
    
    func createNestedGroup2Item1CollectionView() -> NSCollectionLayoutItem {
        let nestedGroup2Item1 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1),
                heightDimension:
                        .fractionalWidth(1)))
        nestedGroup2Item1.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 16)
        return nestedGroup2Item1
    }
    
    func createFooterCollectionView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(80))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom)
        return footer
    }
    
     func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
         
         let item = createItemSizeForCollectionView()
         let group1Item1 = createGroup1Item1CollectionView()
         let nestedGroup1Item1 = createNestedGroup1Item1CollectionView()
         let nestedGroup2Item1 = createNestedGroup2Item1CollectionView()

         let nestedGroup1 = NSCollectionLayoutGroup.vertical(
             layoutSize: NSCollectionLayoutSize(
                 widthDimension:
                         .fractionalWidth(1 / 2),
                 heightDimension:
                         .fractionalWidth(1)),
             subitems: [nestedGroup1Item1, nestedGroup2Item1])
 
         let group1 = NSCollectionLayoutGroup.horizontal(
             layoutSize: NSCollectionLayoutSize(
                 widthDimension:
                         .fractionalWidth(1),
                 heightDimension:
                         .fractionalWidth(1)),
             subitems: [group1Item1, nestedGroup1])
         
         let containerGroup = NSCollectionLayoutGroup.vertical(
             layoutSize: NSCollectionLayoutSize(
                 widthDimension:
                         .fractionalWidth(1),
                 heightDimension:
                         .fractionalWidth(3)),
             subitems: [item, group1])
         
         let section = NSCollectionLayoutSection(group: containerGroup)
         section.boundarySupplementaryItems = [createFooterCollectionView()]
         let layout = UICollectionViewCompositionalLayout(section: section)
         return layout
     }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter.getImages()
        refreshControl.endRefreshing()
    }
}

extension ImagesViewController: ImagesViewProtocol {
    func presentError(error: Error) {
        
    }
    
    func presentImages(images: [Response.RandomImageModel.ImageModelElement]) {
        arrayImages = images.map {
            Response.ViewModelImage(id: $0.id ?? "",
                                    userName: $0.user?.username ?? "",
                                    location: $0.user?.location ?? "",
                                    image: $0.urls?.small ?? "",
                                    createdImage: $0.created_at ?? "",
                                    downloadsCount: $0.downloads ?? 0 )
        }
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
    
    func presentSearchResults(images: Response.SearchImageModel.SearchResults) {
        arrayImages = images.results.map {
            Response.ViewModelImage(id: $0.id ?? "",
                                    userName: $0.user?.username ?? "",
                                    location: $0.user?.location ?? "",
                                    image: $0.urls?.small ?? "",
                                    createdImage: $0.created_at ?? "",
                                    downloadsCount: $0.downloads ?? 0 )
        }
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
}

extension ImagesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            arrayImages = []
            collectionView.reloadData()
        } else {
            presenter.searchImages(query: searchText, page: "\(1)")
        }
        
    }
}
