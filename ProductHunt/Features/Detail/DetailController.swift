//  Created by Ky Nguyen

import UIKit

class DetailController: KNController {
    lazy var tableView = UITableView(cells: [ProductItemCell.self], source: self)
    override var shouldGetDataViewDidLoad: Bool { true }
    let titleCell = ProductItemCell()
    lazy var interactor = DetailInteractor(controller: self)
    
    var datasource = [UITableViewCell]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func setupView() {
        view.backgroundColor = .bg
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .color_201F24
        navigationController?.navigationBar.isTranslucent = false
    }

    func setupTableView() {
        tableView.backgroundColor = .bg
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubviews(views: tableView)
        tableView.fillSuperviewSafeArea()
    }

    let mediaCell = MediaCell()
    let actionCell = ActionButtonCell()
    let descriptionCell = DescriptionCell()
    let tagsCell = TagsCell()
    let ownerCell = OwnerCell()
    let promotedCell = PromotedCell()
    override func getData() {
        interactor.freshGetData()
    }
}

extension DetailController {
    func updateUI(_ product: ProductDetail) {
        var cells = [UITableViewCell]()
        
        mediaCell.setData(product.medias)
        cells.append(mediaCell)
        cells.append(actionCell)
        if let featuredAt = product.featuredAt {
            let featuredCell = FeaturedCell()
            featuredCell.setData(featuredAt)
            cells.append(featuredCell)
        }

        descriptionCell.setData(product.description)
        cells.append(descriptionCell)
        
        tagsCell.setData(product.tags)
        cells.append(tagsCell)
        
        ownerCell.setData(owners: [product.creator], makers: product.makers)
        cells.append(ownerCell)
        
        cells.append(promotedCell)
        
        let commentCells = product.comments.map { CommentCell(comment: $0) }
        cells.append(contentsOf: commentCells)
        
        datasource = cells
    }

    func showError(message: String) {
        let vc = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(vc, animated: true)
    }
}

extension DetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return datasource[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
