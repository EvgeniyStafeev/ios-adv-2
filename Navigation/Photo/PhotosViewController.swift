//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.11.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    var carsPhoto: [UIImage] = []
    var carsPhotoProcessed: [UIImage] = []
    
    let imageProcessor = ImageProcessor()
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collection.backgroundColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return collection
    }()
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carsPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.imageImageView.image = carsPhoto[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let x = (collectionView.bounds.width - 8*4)/3
        return CGSize(width: x, height: x)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        self.title = "Фото Галерея"
        carsPhoto = Photo.PhotoVk
        setupCollectionView()
        
        let group = DispatchGroup()
        group.enter()
        let start = CFAbsoluteTimeGetCurrent()
        imageProcessor.processImagesOnThread(sourceImages: carsPhoto, filter: .colorInvert, qos: .default) { [self] completion in
            for carPhoto in completion {
                if let photo = carPhoto {
                    carsPhotoProcessed.append(UIImage(cgImage: photo))
                    
                }
            }
            
            let diff = CFAbsoluteTimeGetCurrent() - start
            print("Took \(diff) seconds")
            group.leave()
        }
        
        
        group.notify(queue: .main){ [self] in
            carsPhoto = carsPhotoProcessed
            collectionView.reloadData()
        }
        
    }
}
