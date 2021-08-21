//  Created by Ky Nguyen

import UIKit

class HomeController: KNController {
    lazy var tableView = UITableView(cells: [ProductItemCell.self], source: self)
    var datasource = [Int]()

    override func setupView() {
        view.backgroundColor = .color_292A2E
        setupNavigationBar()
        setupTableView()
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

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datasource.count
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductItemCell = tableView.dequeue(at: indexPath)
//        cell.setData(datasource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

class ProductItemCell: KNTableCell {
    let iconImageView = UIImageView()
    let titleLabel = UILabel(font: .main(size: 15), color: .white)
    let descriptionLabel = UILabel(font: .main(size: 15), color: UIColor(hex: "#88898C"), numberOfLines: 2)
    let voteLabel = UILabel(font: .main(.bold, size: 15), color: .white)
    override func setupView() {
        contentView.backgroundColor = .color_292A2E
        let textStackView = makeTextStackView()
        let line = UIView(background: UIColor(hex: "#414045"))
        let voteView = createVoteView()

        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.alignment = .top

        stackView.addViews(iconImageView, textStackView, line, voteView)
        iconImageView.square(edge: 66)
        line.verticalSuperview()
        line.width(1)
        voteView.width(60)

        contentView.addSubviews(views: stackView)
        stackView.horizontalSuperview(space: 16)
        stackView.centerYToSuperview()

        iconImageView.backgroundColor = .green
        titleLabel.text = "Mooze"
        descriptionLabel.text = "Custom overlays to personalize your Zoom settings"
        voteLabel.text = "10002"
    }

    private func makeTextStackView() -> UIStackView {
        let stackView = UIStackView(axis: .vertical, distributon: .fill, alignment: .fill, space: 8)
        stackView.addViews(titleLabel, descriptionLabel)
        return stackView
    }

    private func createVoteView() -> UIStackView {
        let upIcon = UIImageView(imageName: "up")
        let stackView = UIStackView(axis: .vertical, distributon: .fill, alignment: .center, space: 8)
        stackView.addViews(upIcon, voteLabel)
        return stackView
    }
}
