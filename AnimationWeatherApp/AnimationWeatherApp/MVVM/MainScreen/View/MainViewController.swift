import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let mainView = MainView(frame: .zero)
    private var viewModel: MainViewModel
    private var sunView: SunView?
    private var stormView: StormAnimationView?
    private var cloudView: CloudAnimationView?
    private var rainView: RainAnimationView?
    private var snowView: SnowAnimationView?
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupBindings()
        mainView.storyImagesColeectionView.delegate = self
    }
    
    private func setupBindings() {
        mainView.didPressOptionButton = { [weak self] in
            self?.showMenu()
        }
        
        viewModel.didSelectWeather = { [weak self] weather in
            self?.handleWeatherSelection(weather)
            self?.mainView.currentWeather.text = {
                "current_weather_label".localized + " " +  weather.name
            }()
        }
        
        viewModel.weathersDidChange = { [weak self] weathers in
            self?.mainView.weathers = weathers
        }
        viewModel.loadWeathers()
    }
    
    private func setupNavigationItem() {
        let optionButton = mainView.optionButton
        let item = UIBarButtonItem(customView: optionButton)
        navigationItem.rightBarButtonItem = item
    }
    
    private func handleWeatherSelection(_ weather: Weather) {
        switch weather.type {
        case .rainy:
            showRainAnimation()
        case .sunny:
            showSunAnimation()
        case .snowy:
            showSnowyAnimation()
        case .rainThunder:
            showStormAnimation()
        case .partlyCloudy:
            showCloudAnimation()
        }
    }
    
    private func showRainAnimation() {
        removeWeatherAnimations()
        view.backgroundColor = UIColor(named: "badWeather")
        
        let rainView = RainAnimationView(frame: mainView.backAnimationView.bounds)
        rainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.backAnimationView.addSubview(rainView)
        self.rainView = rainView
    }
    
    private func showSnowyAnimation() {
        removeWeatherAnimations()
        view.backgroundColor = UIColor(named: "badWeather")
        
        let snowView = SnowAnimationView(frame: mainView.backAnimationView.bounds)
        snowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.backAnimationView.addSubview(snowView)
        self.snowView = snowView
    }
    
    private func showSunAnimation() {
        removeWeatherAnimations()
        
        let sunView = SunView(frame: mainView.backAnimationView.bounds)
        mainView.backAnimationView.addSubview(sunView)
        self.sunView = sunView
    }
    
    private func showStormAnimation() {
        removeWeatherAnimations()
        view.backgroundColor = UIColor(named: "badWeather")
        let stormView = StormAnimationView(frame: mainView.backAnimationView.bounds)
        mainView.backAnimationView.addSubview(stormView)
        stormView.startLightningAnimation()
        self.stormView = stormView
    }
    
    private func showCloudAnimation() {
        removeWeatherAnimations()
        let cloudView = CloudAnimationView(frame: mainView.backAnimationView.bounds)
        cloudView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.backAnimationView.addSubview(cloudView)
        self.cloudView = cloudView
    }
    
    private func removeWeatherAnimations() {
        view.backgroundColor = UIColor(named: "goodWeather")
        mainView.backAnimationView.layer.sublayers?.removeAll(where: { $0 is CAEmitterLayer })
        stormView?.removeFromSuperview()
        sunView?.removeFromSuperview()
        cloudView?.removeFromSuperview()
        rainView?.removeFromSuperview()
        snowView?.removeFromSuperview()
        sunView = nil
        stormView = nil
        cloudView = nil
        rainView = nil
        snowView = nil
    }
    
    func showMenu() {
        let alertController = UIAlertController(
            title: "select_language".localized,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let russianAction = UIAlertAction(
            title: "russian".localized,
            style: .default
        ) { _ in
            self.changeLanguage(to: "ru")
        }
        
        let englishAction = UIAlertAction(
            title: "english".localized,
            style: .default
        ) { _ in
            self.changeLanguage(to: "en")
        }
        
        let cancelAction = UIAlertAction(
            title: "cancel".localized,
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(russianAction)
        alertController.addAction(englishAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func changeLanguage(to languageCode: String) {
        let defaults = UserDefaults.standard
        defaults.set([languageCode], forKey: "AppleLanguages")
        defaults.synchronize()
        let alert = UIAlertController(
            title: "language_changed".localized,
            message: "app_restart_message".localized,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "ok".localized,
            style: .default,
            handler: { _ in
                exit(0)
            }
        ))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectWeather(at: indexPath.row)
    }
}

