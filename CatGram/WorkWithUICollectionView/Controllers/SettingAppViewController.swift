import UIKit

class SettingAppViewController: UIViewController {

    let settingView = SettingAppView(frame: .zero)

    override func loadView() {
        super.loadView()
        settingView.pushNewNC = { [weak self] in
            self?.navigationController?.pushViewController(ThemesViewController(), animated: true)
        }
        view = settingView
    }
}
