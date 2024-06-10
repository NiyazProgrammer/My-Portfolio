import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    static let identifier = "CurrencyCollectionViewCell"

    private lazy var fullNameCurrency: UILabel = {
         let label = UILabel()
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
         label.numberOfLines = 0
         label.lineBreakMode = .byWordWrapping
         return label
     }()

     private lazy var shortNameCurrency: UILabel = {
         let label = UILabel()
         label.textColor = .gray
         label.font = UIFont.systemFont(ofSize: 12.0)
         return label
     }()

     private lazy var priceInfo: UILabel = {
         let label = UILabel()
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

     private lazy var priceAndshortNameCurrency: UIStackView = {
         let stackView = UIStackView(arrangedSubviews: [priceInfo, shortNameCurrency])
         stackView.axis = .vertical
         stackView.alignment = .fill
         stackView.backgroundColor = .clear
         stackView.spacing = 5
         return stackView
     }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        contentView.addSubview(fullNameCurrency)
        contentView.addSubview(priceAndshortNameCurrency)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        fullNameCurrency.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }

        priceAndshortNameCurrency.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
    }

    func configure(coin: Valute) {
        fullNameCurrency.text = coin.name
        shortNameCurrency.text = coin.charCode
        priceInfo.text = "\(String(describing: coin.value)) RUB"
    }
}
