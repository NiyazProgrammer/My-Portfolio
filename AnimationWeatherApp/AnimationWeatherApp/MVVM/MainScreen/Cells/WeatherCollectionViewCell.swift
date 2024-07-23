import Foundation
import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(weatherImage)
        weatherImage.layer.cornerRadius = 44
        weatherImage.clipsToBounds = true
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setupConfigurations(weather: Weather) {
        weatherImage.image = UIImage(named: weather.image)
    }
}

extension WeatherCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
