import UIKit

class BankCardViewCollectionViewCell: UICollectionViewCell {
    static let identifier = "BankCardCollectionViewCell"
    var addNewTransaction: (() -> Void)?

    private lazy var backImageCard: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
// MARK: Прямое добавление транзакции через главный экран не реализовал
//    private lazy var addImageView: UIButton = {
//        let action = UIAction { [weak self] _ in
//            self?.addNewTransaction?()
//        }
//        let button = UIButton(type: .custom, primaryAction: action)
//        button.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
//        button.imageView?.tintColor = .black
//        button.imageView?.contentMode = .scaleAspectFill
//        return button
//    }()

    private lazy var accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        return label
    }()

    private lazy var nameAndAmountSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountBalanceLabel, cardNameLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        contentView.addSubview(backImageCard)
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameAndAmountSV)
//        contentView.addSubview(addImageView)

        setupLayaut()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayaut() {
        backImageCard.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(35)
        }

        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(backImageCard.snp.top).offset(5)
            make.leading.equalTo(backImageCard.snp.leading).offset(5)
            make.width.height.equalTo(10)
        }

        nameAndAmountSV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(backImageCard.snp.trailing).offset(10)
        }

//        addImageView.snp.makeConstraints { make in
//            make.centerY.equalTo(contentView.snp.centerY)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
//            make.width.height.equalTo(20)
//        }

        backImageCard.layer.cornerRadius = 10
        backImageCard.clipsToBounds = true
    }

    func configure(with card: BankCard) {
        iconImageView.image = UIImage(named: "\(card.labelImage)")
        backImageCard.image = UIImage(named: "\(card.backImage)")
        accountBalanceLabel.text = String(describing: card.totalMoney)
        cardNameLabel.text = card.name
    }
}
