//
//  PortfolioViewController.swift
//  CryptoMarket
//
//  Created by Нияз Ризванов on 06.02.2024.
//

import UIKit

class PortfolioViewController: UIViewController {
    lazy var portfolioView: UIView = {
        PortfolioView(frame: .zero)
    }()

    override func loadView() {
        view = portfolioView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout() {
        navigationItem.title = "Портфель"
    }

}
