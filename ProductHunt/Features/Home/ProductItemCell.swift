//  Created by Ky Nguyen

import UIKit

class ProductItemCell: KNTableCell {
    let iconImageView = UIImageView()
    let titleLabel = UILabel(font: .main(size: 15), color: .white)
    let descriptionLabel = UILabel(font: .main(size: 15), color: UIColor(hex: "#88898C"), numberOfLines: 2)
    let voteLabel = UILabel(font: .main(.bold, size: 15), color: .white)
    override func setupView() {
        iconImageView.clipsToBounds = true
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
    
    func setData(_ data: Product) {
        iconImageView.downloadImage(from: data.thumbnailUrl)
        titleLabel.text = data.name
        descriptionLabel.text = data.description
        voteLabel.text = "\(data.votesCount)"
    }
}
