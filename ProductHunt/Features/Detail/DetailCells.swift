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
        
        func setData(_ data: String) {
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
            scrollView.verticalSuperview(space: 16)
            scrollView.height(48)
        }
        
        func setData(_ data: [String]) {
            datasource = data
        }
    }
}
