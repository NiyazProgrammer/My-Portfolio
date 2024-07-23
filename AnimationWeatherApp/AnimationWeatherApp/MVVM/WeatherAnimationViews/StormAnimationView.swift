//
//  StormAnimationView.swift
//  AnimationWeatherApp
//
//  Created by Нияз Ризванов on 18.07.2024.
//

import UIKit

class StormAnimationView: UIView {
    
    private let rainEmitterLayer = CAEmitterLayer()
    private let lightningLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRainEmitter()
        setupLightningLayer()
        startLightningAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRainEmitter() {
        rainEmitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: -50)
        rainEmitterLayer.emitterSize = CGSize(width: bounds.width, height: 0)
        rainEmitterLayer.emitterShape = .line
        
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(named: "rainDrop")?.cgImage
        rainCell.birthRate = 20
        rainCell.lifetime = 10.0
        rainCell.velocity = 100
        rainCell.velocityRange = 50
        rainCell.emissionLongitude = .pi
        rainCell.yAcceleration = 50
        
        let desiredSize: CGFloat = 10.0
        let image = UIImage(named: "rainDrop")
        let scale = desiredSize / (image?.size.width ?? 1)
        rainCell.scale = scale
        
        rainEmitterLayer.emitterCells = [rainCell]
        layer.addSublayer(rainEmitterLayer)
    }
    
    private func setupLightningLayer() {
        lightningLayer.frame = bounds
        lightningLayer.backgroundColor = UIColor.white.cgColor
        lightningLayer.opacity = 0
        layer.addSublayer(lightningLayer)
    }
    
    func startLightningAnimation() {
        let flashAnimation = CAKeyframeAnimation(keyPath: "opacity")
        flashAnimation.values = [0, 1, 0, 1, 0, 0]
        flashAnimation.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 1.0]
        flashAnimation.duration = 2.0
        flashAnimation.repeatCount = .infinity
        lightningLayer.add(flashAnimation, forKey: "flashAnimation")
    }
}
