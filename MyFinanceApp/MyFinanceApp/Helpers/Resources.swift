import UIKit

enum Resources {
    enum Colors {
        static let active = UIColor(.purple)
        static let mainColorApp = UIColor(.purple)
        static let inactive  = UIColor(hexString: "#bdbdbd")
        static let separator = UIColor(hexString: "bdbdbd")
        static let backgroundViews = UIColor(hexString: "#f7f7f7")

        enum GeneralCardsProfile {
            static let setting: UIColor = .lightGray
            static let favorites = UIColor(hexString: "#fef5e4")
            static let notification = UIColor(hexString: "#feeaeb")
        }

        enum SecurityCardsSetting {
            static let appsPassword: UIColor = .green
            static let changePassword: UIColor = .lightGray
            static let notification = UIColor(hexString: "#f84608")
        }
    }
    
    enum Strings {
        enum TabBar {
            static var myMoney = "Мои деньги"
            static let budget = "Бюджет"
            static let lenta = "Лента"
            static let courses = "Курсы"
            static let profile = "Профиль"
        }

        enum GeneralCardsProfile {
            static let setting = "Настройки"
            static let favorites = "Избранные"
            static let notification = "Уведомления"
        }

        enum SecurityCardsProfile {
            static let appsPassword = "Код-пароль"
            static let changePassword = "Изменить пароль"
            static let notification = "Push-Уведомления"
        }

        enum ChangeDataCards {
            enum TitleCard {
                static let email = "E-mail"
                static let nameUser = "Имя пользователя"
            }
            enum PlaceholderCard {
                static let email = "Введите Email "
                static let nameUser = "Введите имя пользователя"
            }
        }

        enum ChangePasswordCards {
            enum PlaceholderCard {
                static let currentPassword = "Ваш текущий пароль"
                static let newPassword = "Придумайте новый пароль"
                static let confirmNewPassword = "Подтвердите новый пароль"
            }
        }

        static let all: [String] = ["Лента", "Валюта"]

        static let currencies: [String] = ["USD", "EUR", "KZT", "AED", "TRY"]
    }

    enum Images {
        static let mainAppIcon = UIImage(named: "LaunchImage")

        enum TabBar {
            static let home = UIImage(systemName: "house")
            static let budget = UIImage(systemName: "creditcard")
            static let lenta = UIImage(systemName: "newspaper")
            static let courses = UIImage(systemName: "chart.bar.xaxis")
            static let profile = UIImage(systemName: "person.crop.circle")
        }

        enum GeneralCardsProfile {
            static let setting = UIImage(named: "setting")
            static let favorites = UIImage(named: "favorites")
            static let notification = UIImage(named: "notification")
        }

        enum SecurityCardsProfile {
            static let appsPassword = UIImage(named: "faceid")
            static let changePassword = UIImage(named: "changePassword")
            static let notification = UIImage(named: "notificationSecurity")
            static let rightArrow = UIImage(named: "rightArrow")
        }

        enum ChangeDataCards {
            static let editPencil = UIImage(systemName: "pencil")
            static let defaultAvatar = UIImage(named: "defaultAvatar")
        }
    }

    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }

    enum NumbersItemCount {
        static let currencyCount = 5
    }
}
