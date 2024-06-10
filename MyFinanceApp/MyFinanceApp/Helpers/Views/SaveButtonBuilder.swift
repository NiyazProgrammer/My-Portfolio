import UIKit

class SaveButtonBuilder {
    private var title: String?
    private var backgroundColor: UIColor?
    private var cornerRadius: CGFloat?

    func setTitle(_ title: String) -> Self {
        self.title = title
        return self
    }

    func setBackgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    func setCornerRadius(_ radius: CGFloat) -> Self {
        self.cornerRadius = radius
        return self
    }

    func build() -> UIButton {
        let button = UIButton()
        button.setTitle(self.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = self.backgroundColor
        button.layer.cornerRadius = self.cornerRadius ?? 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.clipsToBounds = true

        return button
    }
}
