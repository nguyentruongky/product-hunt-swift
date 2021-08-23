//  Created by Ky Nguyen

import UIKit

class CommentCell: KNTableCell {
    convenience init(comment data: Comment) {
        self.init()
        setData(data)
    }
    let userImageView = UIImageView(contentMode: .scaleAspectFill)
    let nameLabel = UILabel(font: .main(.bold, size: 15), color: .white)
    let headlineLabel = UILabel(font: .main(size: 15), color: UIColor(hex: "#86878B"))
    let contentLabel = UILabel(font: .main(size: 15), color: .white, numberOfLines: 0)
    let upvoteButton = UIButton(title: "Upvote", titleColor: .color_86878B, font: .main(.bold, size: 13))
    let menuButton = UIButton(imageName: "menu")
    let createdAtLabel = UILabel(font: .main(.bold, size: 13), color: .color_86878B)

    override func setupView() {
        contentView.backgroundColor = .bg
        userImageView.setCorner(radius: 22)
        layoutUserView()
        
        contentView.addSubviews(views: contentLabel)
        contentLabel.horizontalSuperview(space: 24)
        contentLabel.verticalSpacing(toView: userImageView, space: 24)
        
        layoutFooterView()
    }
    
    private func layoutUserView() {
        contentView.addSubviews(views: userImageView)
        userImageView.square(edge: 44)
        userImageView.leftToSuperview(space: 24)
        userImageView.topToSuperview()
        
        let stackView = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, space: 2)
        stackView.addArrangeViews(views: nameLabel, headlineLabel)
        contentView.addSubviews(views: stackView)
        stackView.leftHorizontalSpacing(toView: userImageView, space: 16)
        stackView.rightToSuperview()
        stackView.centerY(toView: userImageView)
    }
    
    func setData(_ data: Comment) {
        userImageView.downloadImage(from: data.creator.imageUrl)
        nameLabel.text = data.creator.name
        headlineLabel.text = data.creator.headline
        contentLabel.text = data.body
        upvoteButton.setTitle("Upvote (\(data.voteCount))")
        createdAtLabel.text = data.createdAt
    }
    
    
    private func layoutFooterView() {
        let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, space: 16)
        stackView.addArrangeViews(views: upvoteButton, menuButton, createdAtLabel)
        contentView.addSubviews(views: stackView)
        stackView.leftToSuperview(space: 24)
        stackView.verticalSpacing(toView: contentLabel, space: 16)
        stackView.bottomToSuperview(space: -24)
    }
}
