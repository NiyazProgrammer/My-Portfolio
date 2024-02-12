//
//  ViewController.swift
//  CryptoMarket
//
//  Created by Нияз Ризванов on 03.02.2024.
//

import UIKit

class MainPageMarketViewController: UIViewController {
    
    lazy var mainView = MainPageMarketView(frame: .zero)

    override func loadView() {
        super.loadView()

        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var netWorkObject = NetWorkingManager(with: .default)
        Task {
            do {
                let coins = try await netWorkObject.obtainCoins()
                mainView.coin = coins
                mainView.keys = netWorkObject.obtainCountryKeys(with: coins!.Valute)
                mainView.tableCoins.reloadData()
            }
            catch {
                printContent("Error netWork")
            }
        }
    }


}

