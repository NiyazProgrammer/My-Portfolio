import UIKit

class CloudAnimationView: UIView {
    private let numberOfClouds = 6
    private let cloudSize = CGSize(width: 210, height: 200)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cloudLayer = CALayer()
        cloudLayer.contents = UIImage(named: "sunny")?.cgImage
        cloudLayer.frame = CGRect(
            x: 30,
            y: 20,
            width: 300,
            height: 300
        )
        self.layer.addSublayer(cloudLayer)
        
        setupCloudLayers()
        startCloudAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.setupAdditionalCloudLayers()
            self.startAdditionalCloudAnimation()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCloudLayers() {
        createCloud(image: UIImage(named: "cloudDrop4"), number: 0)
        createCloud(image: UIImage(named: "cloudDrop3"), number: 1)
        createCloud(image: UIImage(named: "cloudDrop2"), number: 2)
        createCloud(image: UIImage(named: "cloudDrop1"), number: 0)
        createCloud(image: UIImage(named: "cloudDrop5"), number: 1)
        createCloud(image: UIImage(named: "cloudDrop6"), number: 2)
    }
    
    private func setupAdditionalCloudLayers() {
        createCloud(image: UIImage(named: "cloudDrop4"), number: 0)
        createCloud(image: UIImage(named: "cloudDrop3"), number: 1)
        createCloud(image: UIImage(named: "cloudDrop2"), number: 2)
        createCloud(image: UIImage(named: "cloudDrop1"), number: 0)
        createCloud(image: UIImage(named: "cloudDrop5"), number: 1)
        createCloud(image: UIImage(named: "cloudDrop6"), number: 2)
    }
    
    private func createCloud(image: UIImage?, number: Int) {
        guard let cloudImage = image?.cgImage else { return }
        let overlap: CGFloat = 50
        let totalWidth = CGFloat(numberOfClouds) * cloudSize.width - CGFloat(numberOfClouds - 1) * overlap
        
        let cloudLayer = CALayer()
        cloudLayer.contents = cloudImage
        cloudLayer.frame = CGRect(
            x: (bounds.width - totalWidth) / 2 + CGFloat(number % numberOfClouds) * (cloudSize.width - overlap),
            y: 50,
            width: cloudSize.width,
            height: cloudSize.height
        )
        cloudLayer.name = "cloudLayer\(number)"
        self.layer.addSublayer(cloudLayer)
    }
    
    private func startCloudAnimation() {
        var number = 0
        for (_, layer) in (self.layer.sublayers ?? []).enumerated() {
            guard layer.name?.starts(with: "cloudLayer") == true else { continue }
            let animation = CABasicAnimation(keyPath: "position.x")
            animation.fromValue = -cloudSize.width + CGFloat(number) * cloudSize.width / CGFloat(numberOfClouds)
            animation.toValue = bounds.width + cloudSize.width
            animation.duration = 25.0
            animation.repeatCount = .infinity
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            layer.add(animation, forKey: "cloudAnimation")
            number += 2
        }
    }
    
    private func startAdditionalCloudAnimation() {
        let additionalLayers = self.layer.sublayers?.suffix(from: numberOfClouds) ?? []
        var number = 0
        for (_, layer) in additionalLayers.enumerated() {
            guard layer.name?.starts(with: "cloudLayer") == true else { continue }
            let animation = CABasicAnimation(keyPath: "position.x")
            animation.fromValue = -cloudSize.width + CGFloat(number) * cloudSize.width / CGFloat(numberOfClouds)
            animation.toValue = bounds.width + cloudSize.width
            animation.duration = 30.0
            animation.repeatCount = .infinity
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            layer.add(animation, forKey: "cloudAnimation")
            number += 2
        }
    }
}
