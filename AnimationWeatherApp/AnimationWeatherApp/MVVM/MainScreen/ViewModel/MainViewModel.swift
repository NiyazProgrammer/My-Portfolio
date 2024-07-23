//
//  MainViewModel.swift
//  AnimationWeatherApp
//
//  Created by Нияз Ризванов on 18.07.2024.
//

import Foundation

class MainViewModel {
    var didSelectWeather: ((Weather) -> Void)?
    var weathersDidChange: (([Weather]) -> Void)?

    private var weathers: [Weather] = [
        Weather(
            name: "rainy".localized,
            image: "Rainy",
            type: .rainy
        ),
        Weather(
            name: "sunny".localized,
            image: "Sunny",
            type: .sunny
        ),
        Weather(
            name: "snowy".localized,
            image: "Snowy",
            type: .snowy
        ),
        Weather(
            name: "rain_thunder".localized,
            image: "RainThunder",
            type: .rainThunder
        ),
        Weather(
            name: "partly_cloudy".localized,
            image: "PartlyCloudy",
            type: .partlyCloudy
        )
    ] {
        didSet {
            weathersDidChange?(weathers)
        }
    }

    func loadWeathers() {
        weathersDidChange?(weathers)
    }

    func selectWeather(at index: Int) {
        let weather = weathers[index]
        didSelectWeather?(weather)
    }
}
