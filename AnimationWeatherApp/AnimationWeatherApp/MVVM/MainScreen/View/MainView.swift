import UIKit
import SnapKit

class MainView: UIView {

    lazy var backAnimationView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    lazy var storyImagesColeectionView: UICollectionView = {
        var size = ((UIScreen.main.bounds.size.width) / 4) - 10
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: size, height: size)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(
            WeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    lazy var optionButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.didPressOptionButton?()
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setImage(UIImage(systemName: "ellipsis.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    lazy var currentWeather: UILabel = {
        let label = UILabel()
        label.text = "choose_weather_animation".localized
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    var weathers: [Weather] = [] {
        didSet {
            storyImagesColeectionView.reloadData()
        }
    }

    var didPressOptionButton: (() -> Void)?

    private lazy var homeImage: UIImageView = {
        let picture = UIImageView(image: UIImage(named: "house"))
        picture.contentMode = .scaleAspectFit
        return picture
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "goodWeather")
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(backAnimationView)
        backAnimationView.addSubview(homeImage)
        addSubview(storyImagesColeectionView)
        addSubview(currentWeather)

        backAnimationView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        storyImagesColeectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }

        currentWeather.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview()
        }

        homeImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(currentWeather.snp.top).offset(-30)
        }
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier,
            for: indexPath) as? WeatherCollectionViewCell {

            let currentWeather = weathers[indexPath.row]
            cell.setupConfigurations(weather: currentWeather)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
