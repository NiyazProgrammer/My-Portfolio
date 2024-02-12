//
//  PortfolioView.swift
//  CryptoMarket
//
//  Created by Нияз Ризванов on 06.02.2024.
//

import UIKit

class PortfolioView: UIView {
    lazy var backView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var generalLabelBalance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Общий баланс"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()

    lazy var labelBalance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 $"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()

    lazy var buttonEnter: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ввод", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.layer.cornerRadius = 20
        return button
    }()

    lazy var buttonBuy: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Купить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.layer.cornerRadius = 20
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.4)
        addSubview(backView)
        backView.addSubview(labelBalance)
        backView.addSubview(generalLabelBalance)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [buttonEnter, buttonBuy])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        backView.addSubview(stackView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: 1500),
            generalLabelBalance.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            generalLabelBalance.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            labelBalance.topAnchor.constraint(equalTo: generalLabelBalance.bottomAnchor, constant: 10),
            labelBalance.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            stackView.topAnchor.constraint(equalTo: labelBalance.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: 5),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 10)

        ])
    }

}
