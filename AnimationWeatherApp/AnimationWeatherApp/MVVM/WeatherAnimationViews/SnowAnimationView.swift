import UIKit

class SnowAnimationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSnowEmitter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSnowEmitter() {
        let snowEmitter = CAEmitterLayer()
        snowEmitter.emitterPosition = CGPoint(x: bounds.width / 2, y: -50)
        snowEmitter.emitterSize = CGSize(width: bounds.width, height: 0)
        snowEmitter.emitterShape = .line

        let snowCell = CAEmitterCell()
        snowCell.contents = UIImage(named: "snowyDrop")?.cgImage
        snowCell.birthRate = 5
        snowCell.lifetime = 20.0
        snowCell.velocity = 50
        snowCell.velocityRange = 20
        snowCell.emissionLongitude = .pi
        snowCell.emissionRange = .pi / 4
        let desiredSize: CGFloat = 20.0
        let image = UIImage(named: "snowyDrop")
        let scale = desiredSize / (image?.size.width ?? 1)
        snowCell.scale = scale

        snowEmitter.emitterCells = [snowCell]
        layer.addSublayer(snowEmitter)
    }
}
