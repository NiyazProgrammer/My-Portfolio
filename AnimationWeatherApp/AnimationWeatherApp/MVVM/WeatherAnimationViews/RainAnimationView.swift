//
//  RainAnimationView.swift
//  AnimationWeatherApp
//
//  Created by Нияз Ризванов on 23.07.2024.
//

import UIKit

class RainAnimationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRainEmitter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupRainEmitter() {
        let rainEmitter = CAEmitterLayer()
        rainEmitter.emitterPosition = CGPoint(x: bounds.width / 2, y: -50)
        rainEmitter.emitterSize = CGSize(width: bounds.width, height: 0)
        rainEmitter.emitterShape = .line

        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(named: "rainDrop")?.cgImage
        rainCell.birthRate = 50
        rainCell.lifetime = 10.0
        rainCell.velocity = 200
        rainCell.velocityRange = 100
        rainCell.emissionLongitude = .pi
        rainCell.yAcceleration = 100
        let desiredSize: CGFloat = 10.0
        let image = UIImage(named: "rainDrop")
        let scale = desiredSize / (image?.size.width ?? 1)
        rainCell.scale = scale

        rainEmitter.emitterCells = [rainCell]
        layer.addSublayer(rainEmitter)
    }
}
