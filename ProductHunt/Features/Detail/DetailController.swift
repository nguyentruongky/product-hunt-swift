//  Created by Ky Nguyen

import UIKit

class DetailController: KNController {
    lazy var tableView = UITableView(cells: [ProductItemCell.self], source: self)
    override var shouldGetDataViewDidLoad: Bool { true }
    let titleCell = ProductItemCell()
    
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
    override func getData() {
        let featuredCell = FeaturedCell()
        let cells = [
            mediaCell,
            actionCell,
            featuredCell,
            descriptionCell,
            tagsCell
        ]
                
        let media = [
            Media(type: .image, url: "https://ph-files.imgix.net/28dd4b89-e876-42bc-b005-8e3136cbddb9.png?auto=format&auto=compress&codec=mozjpeg&cs=strip&w=635&h=380&fit=max&dpr=2"),
            Media(type: .image, url: "https://ph-files.imgix.net/8fda5b92-eaab-4e28-a490-0cb08394af5a.png?auto=format&auto=compress&codec=mozjpeg&cs=strip&w=635&h=380&fit=max&dpr=2"),
            Media(type: .image, url: "https://ph-files.imgix.net/1ee0988e-f6df-4edc-88ce-cc36c1357124.png?auto=format&auto=compress&codec=mozjpeg&cs=strip&w=635&h=380&fit=max&dpr=2")
        ]
        
        tagsCell.setData(["PRODUCTIVITY", "EVENTS", "SOCIAL NETWORK", "IOS DEVELOPMENT"])

        mediaCell.setData(media)
        descriptionCell.setData("""
            bloop is an in-IDE code search engine that retrieves relevant JS and TypeScript code examples from library documentation and open-source repos.
            ⠀
            See library function parameters, output, and error-handling - without going to Google.
            Have a question about this product? Ask the Maker
            """
        )
        
        datasource = cells
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
