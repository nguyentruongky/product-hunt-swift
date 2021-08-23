//  Created by Ky Nguyen

import UIKit

extension DetailController {
    class MediaCell: KNTableCell {
        var datasource = [Media]() {
            didSet {
                collectionView.reloadData()
            }
        }
        lazy var collectionView = UICollectionView(cells: [MediaItemCollectionCell.self], source: self)
        override func setupView() {
            contentView.backgroundColor = UIColor.bg
            collectionView.backgroundColor = UIColor.bg
            collectionView.showsHorizontalScrollIndicator = false
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            contentView.addSubviews(views: collectionView)
            collectionView.fillSuperView()
            collectionView.height(300)
        }
        
        func setData(_ data: [Media]) {
            datasource = data
        }
    }
    
    class MediaItemCollectionCell: UICollectionViewCell {
        let imageView = UIImageView(contentMode: .scaleAspectFill)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        func setupView() {
            contentView.backgroundColor = UIColor.bg
            contentView.addSubviews(views: imageView)
            imageView.fillSuperView()
        }
        
        func setData(_ data: Media) {
            imageView.downloadImage(from: data.url)
        }
    }
}

extension DetailController.MediaCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailController.MediaItemCollectionCell = collectionView.dequeue(at: indexPath)
        cell.setData(datasource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
