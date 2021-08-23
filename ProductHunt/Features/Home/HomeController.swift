//  Created by Ky Nguyen

import UIKit

class HomeController: KNController {
    lazy var interactor = HomeInteractor(controller: self)
    lazy var tableView = UITableView(cells: [ProductItemCell.self], source: self)
    override var shouldGetDataViewDidLoad: Bool { true }
    var datasource = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func setupView() {
        view.backgroundColor = .bg
        setupNavigationBar()
        setupTableView()
    }

    override func getData() {
        interactor.freshGetData()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .color_201F24
        navigationController?.navigationBar.isTranslucent = false
        let logoImageView = UIImageView(imageName: "logo")
        logoImageView.square(edge: 32)
        navigationItem.titleView = logoImageView

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(pressUserButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#838385")
    }

    @objc func pressUserButton() {

    }

    func setupTableView() {
        tableView.backgroundColor = .color_201F24
        view.addSubviews(views: tableView)
        tableView.fillSuperviewSafeArea()

        let todayLabel = UILabel(text: "Today", font: .main(.bold, size: 17), color: .white)
        let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 48)))
        headerView.backgroundColor = .color_201F24
        headerView.addSubviews(views: todayLabel)
        todayLabel.leftToSuperview(space: 16)
        todayLabel.centerYToSuperview()
        tableView.tableHeaderView = headerView

    }
}

extension HomeController {
    func freshUpdateDatasource(_ products: [Product]) {
        datasource = products
    }

    func updateDatasource(_ products: [Product]) {
        datasource.append(contentsOf: products)
    }

    func showError(message: String) {
        let vc = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(vc, animated: true)
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductItemCell = tableView.dequeue(at: indexPath)
        cell.setData(datasource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailController()
        vc.productId = datasource[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        let isScrollingUp = translation.y < 0
        let isReachingToEnd = scrollView.contentOffset.y + scrollView.frame.height < scrollView.contentSize.height - 100
        if isScrollingUp && isReachingToEnd {
            interactor.loadMoreData()
        }
    }
}
