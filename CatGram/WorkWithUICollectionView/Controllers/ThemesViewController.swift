import UIKit

class ThemesViewController: UIViewController {
    let themeView = ThemesView(frame: .zero)

    override func loadView() {
        super.loadView()
        view = themeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let themes = ThemesDataManager.shared.getThemesApp()
        themeView.setThemesApp(themes: themes)
    }

}
