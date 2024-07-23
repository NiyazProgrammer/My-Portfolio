
import UIKit

class SunView: UIView {
    private let sunLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSunLayer()
        startScaleAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSunLayer() {
        sunLayer.contents = UIImage(named: "sunny")?.cgImage
        sunLayer.frame = CGRect(
            x: 0,
            y: 30,
            width: 300,
            height: 300
        )
        self.layer.addSublayer(sunLayer)
    }

    private func startScaleAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.1
        scaleAnimation.duration = 2.0
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity

        sunLayer.add(scaleAnimation, forKey: "scaleAnimation")
    }
}
