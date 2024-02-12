import UIKit

class OptionsSheetViewController: UIViewController {
    let optionsSheetView = OptionsSheetView( frame: .zero)
    override func loadView() {
        super.loadView()
        optionsSheetView.dismisNC = { [weak self] in
            self?.navigationController?.dismiss(animated: false)
        }
        view = optionsSheetView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let optionsElements = OptionsElementDataManager.shared.getOptionsElement()
        optionsSheetView.setDataElementOptions(optionElement: optionsElements)
    }
}
