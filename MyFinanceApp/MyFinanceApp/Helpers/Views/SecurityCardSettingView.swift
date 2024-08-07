import UIKit

class SecurityCardSettingView: UIView {
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    lazy var nameCardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    lazy var conteynerImageView: UIView = {
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

    lazy var imageCard: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var nextRightArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rightArrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(cardName: String, image: UIImage, color: UIColor) {
        super.init(frame: .zero)
        
        nameCardLabel.text = cardName
        imageCard.image = image
        conteynerImageView.backgroundColor = color

        backgroundColor = .clear
        addSubview(cardView)
        addSubview(nameCardLabel)
        addSubview(conteynerImageView)
        addSubview(imageCard)
        addSubview(nextRightArrow)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 80),

            conteynerImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            conteynerImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            conteynerImageView.widthAnchor.constraint(equalToConstant: 40),
            conteynerImageView.heightAnchor.constraint(equalToConstant: 40),

            imageCard.centerXAnchor.constraint(equalTo: conteynerImageView.centerXAnchor),
            imageCard.centerYAnchor.constraint(equalTo: conteynerImageView.centerYAnchor),
            imageCard.widthAnchor.constraint(equalToConstant: 20),
            imageCard.heightAnchor.constraint(equalToConstant: 20),

            nameCardLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            nameCardLabel.leadingAnchor.constraint(equalTo: conteynerImageView.trailingAnchor, constant: 20),

            nextRightArrow.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            nextRightArrow.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)
        ])
    }
}
