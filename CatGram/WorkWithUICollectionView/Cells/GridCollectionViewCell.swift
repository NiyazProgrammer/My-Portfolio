import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    func configure(with publication: Publication) {
        if let iamgeForGrid = publication.imageData {
            image.image = UIImage(data: iamgeForGrid)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GridCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
