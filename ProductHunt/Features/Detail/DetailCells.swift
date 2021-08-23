//  Created by Ky Nguyen

import UIKit

extension DetailController {
    class ActionButtonCell: KNTableCell {
        let getButton = UIButton(title: "GET IT", titleColor: .black, font: .main(.bold, size: 15), background: .white, cornerRadius: 5)
        let upVoteButton = UIButton(title: "UPVOTE", titleColor: .black, font: .main(.bold, size: 15), background: UIColor(hex: "#DA552D"), cornerRadius: 5)
        
        override func setupView() {
            contentView.backgroundColor = UIColor.bg
            let upImageView = UIImageView(imageName: "up")
            upImageView.changeColor(to: .black)
            upVoteButton.addSubviews(views: upImageView)
            upImageView.square(edge: 16)
            upImageView.horizontalSpacing(toView: upVoteButton.titleLabel!, space: 8)
            upImageView.centerYToSuperview()

            let stack = UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, space: 16)
            stack.addArrangeViews(views: getButton, upVoteButton)
            contentView.addSubviews(views: stack)
            stack.fillSuperView(space: UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24))
            stack.height(44)
        }
    }
    
    class FeaturedCell: KNTableCell {
        let featuredAtLabel = UILabel(text: "FEATURED", font: .main(.medium, size: 15), color: UIColor(hex: "#87888B"))
        
        override func setupView() {
            contentView.backgroundColor = UIColor.bg
            contentView.addSubviews(views: featuredAtLabel)
            featuredAtLabel.fillSuperView(space: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
        }
        
        func setData(_ data: String) {
            featuredAtLabel.text = data
        }
    }
    
    class DescriptionCell: KNTableCell {
        let contentLabel = UILabel(font: .main(size: 15), color: .white, numberOfLines: 0)
        
        override func setupView() {
            contentView.backgroundColor = UIColor.bg
            contentView.addSubviews(views: contentLabel)
            contentLabel.fillSuperView(space: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
        }
        
        func setData(_ data: String?) {
            contentLabel.text = data
        }
    }
    
    class TagsCell: KNTableCell {
        private let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, space: 16)
        private var datasource = [String]() {
            didSet {
                stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                renderItems()
            }
        }
        
        private func renderItems() {
            datasource.forEach {
                let button = UIButton(title: $0, titleColor: UIColor(hex: "#98989A"), font: .main(), background: .clear, cornerRadius: 5, borderWidth: 1, borderColor: UIColor(hex: "#393A3E")!)
                button.titleLabel?.font = .main(.medium, size: 15)
                button.contentEdgeInsets = UIEdgeInsets(space: 8)
                stackView.addArrangeViews(views: button)
            }
        }
        
        override func setupView() {
            contentView.backgroundColor = .bg
            let scrollView = UIScrollView(background: .bg)
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.addSubviews(views: stackView)
            stackView.fillSuperView()
            
            contentView.addSubviews(views: scrollView)
            scrollView.horizontalSuperview(space: 24)
            scrollView.verticalSuperview(space: 8)
            scrollView.height(48)
        }
        
        func setData(_ data: [String]) {
            datasource = data
        }
    }
    
    class OwnerCell: KNTableCell {
        private let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, space: 16)
        
        private func renderItem(user: User) {
            let view = OwnerView(user: user)
            stackView.addArrangeViews(views: view)
        }
        
        override func setupView() {
            contentView.backgroundColor = .bg
            
            let scrollView = UIScrollView(background: .bg)
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.addSubviews(views: stackView)
            stackView.fillSuperView()
            
            contentView.addSubviews(views: scrollView)
            scrollView.horizontalSuperview(space: 24)
            scrollView.verticalSuperview(space: 16)
            scrollView.height(48)
            
            let line = UIView(background: UIColor(hex: "#414045"))
            line.height(1)
            contentView.addSubviews(views: line)
            line.horizontalSuperview()
            line.topToSuperview()
        }
        
        func setData(owners: [User], makers: [User]) {
            owners.forEach {
                renderItem(user: $0)
            }
            
            let line = UIView(background: UIColor(hex: "#414045"))
            line.width(1)
            stackView.addArrangeViews(views: line)
            
            makers.forEach {
                renderItem(user: $0)
            }
        }

    }
    
    class OwnerView: KNView {
        convenience init(user: User) {
            self.init()
            imageView.downloadImage(from: user.imageUrl)
            nameLabel.text = user.name
        }
        let imageView = UIImageView(contentMode: .scaleAspectFill)
        let tagView = UIButton(title: "H", titleColor: .white, font: .main(.bold, size: 12), background: .black, cornerRadius: 12, borderWidth: 1, borderColor: .white)
        let nameLabel = UILabel(font: .main(.bold, size: 15), color: .white)

        override func setupView() {
            imageView.setCorner(radius: 22)
            addSubviews(views: imageView)
            imageView.square(edge: 44)
            imageView.leftToSuperview()
            imageView.verticalSuperview()
            
            addSubviews(views: tagView)
            tagView.square(edge: 24)
            tagView.topRight(toView: imageView, topSpace: 0, rightSpace: 16)
            
            addSubviews(views: nameLabel)
            nameLabel.leftHorizontalSpacing(toView: imageView, space: 24)
            nameLabel.rightToSuperview()
            nameLabel.centerYToSuperview()
        }
    }
    
    class PromotedCell: KNTableCell {
        let productImageView = UIImageView(contentMode: .scaleAspectFill)
        let nameLabel = UILabel(font: .main(.bold, size: 15), color: .white)
        let headlineLabel = UILabel(font: .main(size: 15), color: .color_86878B)

        override func setupView() {
            contentView.backgroundColor = .bg
            let view = UIView(background: .color_201F24)
            view.setBorder(width: 1, color: .color_424244)
            view.setCorner(radius: 3)
            
            view.addSubviews(views: productImageView)
            productImageView.square(edge: 66)
            productImageView.leftToSuperview(space: 16)
            productImageView.verticalSuperview(space: 16)
            
            let stackView = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, space: 2)
            stackView.addArrangeViews(views: nameLabel, headlineLabel)
            view.addSubviews(views: stackView)
            stackView.leftHorizontalSpacing(toView: productImageView, space: 16)
            stackView.rightToSuperview(space: -16)
            stackView.top(toView: productImageView)
            
            contentView.addSubviews(views: view)
            view.fillSuperView(space: UIEdgeInsets(top: 16, left: 16, bottom: 32, right: 16))
            
            layoutSeparatorLines()
            
            // Dummy data
            productImageView.downloadImage(from: "https://ph-files.imgix.net/611bd775-f1ec-44c4-afcc-fbc94caf8750.png?auto=format&auto=compress&codec=mozjpeg&cs=strip&w=100&h=100&fit=crop&dpr=2")
            nameLabel.text = "bloop"
            headlineLabel.text = "Code-search engine for developers"
        }
        
        func layoutSeparatorLines() {
            let topLine = UIView(background: .color_424244)
            contentView.addSubviews(views: topLine)
            topLine.height(1)
            topLine.horizontalSuperview()
            topLine.topToSuperview()
            
            let bottomLine = UIView(background: .color_424244)
            contentView.addSubviews(views: bottomLine)
            bottomLine.height(1)
            bottomLine.horizontalSuperview()
            bottomLine.bottomToSuperview(space: -16)

        }
    }
}
