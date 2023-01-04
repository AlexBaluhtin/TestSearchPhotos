# TestSearchPhotosApp
This is a test task for the position of iOS developer

## About project:

I had to make a screen with random photos from the internet. Photo description screen, where you can add to favorites or remove from favorites. And the screen of the list of favorite photos, from which it is also possible to go to the detailed description of the photo

### API

To work with the network, I used the moya framework. All upload work happens in the network service

### Storage

In order to see my favorite photos, I added a realm database. All work on loading, saving and deleting takes place in the storage service.

## UI

To display pictures, I used a collectionview, a tableview. For beautiful placement of pictures on the screen, I used UICollectionViewCompositionalLayout. 
For quick image rendering I used GCD

## Created with:

- Swift
- Foundation
- UIKit
- Realm
- MVP Architecture
- Auto Layout
- GCD
- Moya

## Launch of the project:
In order to run the project, you need to install pods

