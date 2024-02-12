//
//  MainPageMarketView.swift
//  CryptoMarket
//
//  Created by Нияз Ризванов on 03.02.2024.
//

import UIKit

class MainPageMarketView: UIView {

    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Список монет"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    lazy var tableCoins: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(CoinsCellTableViewCell.self, forCellReuseIdentifier: "coinsCell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        //backgroundColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.4)
        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(tableCoins)
        setupLayoutHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var coin: Coin?
    var keys: [String]?
    //var keys: [String] = ["USD","EUR","KZT","CAD","GBP","JPY","AZN","AED","CNY","TRY"]

    func setupLayoutHeader() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            tableCoins.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableCoins.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableCoins.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableCoins.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension MainPageMarketView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberCoin = coin?.Valute.count else { return 0 }
        return numberCoin
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinsCell", for: indexPath) as! CoinsCellTableViewCell
        let country = keys?[indexPath.row]
        let coinInfo = coin?.Valute[country!]
        cell.configure(coin: coinInfo!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
