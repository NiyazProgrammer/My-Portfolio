import UIKit

class GeneralProfileTableViewCell: UITableViewCell {

    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    private lazy var nameCardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var conteynerImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()

    private lazy var imageCard: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(cardView)
        contentView.addSubview(nameCardLabel)
        contentView.addSubview(conteynerImageView)
        contentView.addSubview(imageCard)

        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String, image: UIImage, color: UIColor) {
        nameCardLabel.text = title
        imageCard.image = image
        conteynerImageView.backgroundColor = color
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 80),

            nameCardLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            nameCardLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),

            conteynerImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            conteynerImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            conteynerImageView.widthAnchor.constraint(equalToConstant: 40),
            conteynerImageView.heightAnchor.constraint(equalToConstant: 40),

            imageCard.centerXAnchor.constraint(equalTo: conteynerImageView.centerXAnchor),
            imageCard.centerYAnchor.constraint(equalTo: conteynerImageView.centerYAnchor),
            imageCard.widthAnchor.constraint(equalToConstant: 20),
            imageCard.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}

extension GeneralProfileTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
