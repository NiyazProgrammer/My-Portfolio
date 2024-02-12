//
//  CoinsCellTableViewCell.swift
//  CryptoMarket
//
//  Created by Нияз Ризванов on 03.02.2024.
//

import UIKit

class CoinsCellTableViewCell: UITableViewCell {

    lazy var coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 15
        imageView.image = UIImage(named: "bitcoin")
        return imageView
    }()
    lazy var fullNameCoin: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    lazy var shortNameCoin: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var priceInfo: UILabel = {
        let label = UILabel()
        label.text = "43 061,98 $"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        contentView.addSubview(coinImage)
        contentView.addSubview(priceInfo)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        let stackViewName = UIStackView(arrangedSubviews: [fullNameCoin, shortNameCoin])
        stackViewName.translatesAutoresizingMaskIntoConstraints = false
        stackViewName.axis = .vertical
        stackViewName.alignment = .fill
        stackViewName.backgroundColor = .clear
        stackViewName.spacing = 5
        contentView.addSubview(stackViewName)

        NSLayoutConstraint.activate([

            coinImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            coinImage.widthAnchor.constraint(equalToConstant: 30),
            coinImage.heightAnchor.constraint(equalToConstant: 30),
            stackViewName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewName.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 15),
            stackViewName.widthAnchor.constraint(equalToConstant: 200),
            priceInfo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    func configure(coin: Valute) {
        fullNameCoin.text = coin.Name
        shortNameCoin.text = coin.CharCode
        priceInfo.text = "\(String(describing: coin.Value)) RUB"
    }


}
