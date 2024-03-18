import UIKit

enum Resources {
    enum Colors {
        static var backgroundViews = UIColor(hexString: "#f7f7f7")
    }
    
    enum Strings {
        static let aboutMe = "About me"
    }
    enum Images {
        enum baseView {
            static let logoApp = UIImage(named: "logoApp")
        }
        enum ActionButton {
            static let like = UIImage(named: "like")
            static let disLike = UIImage(named: "dislike")
            static let back = UIImage(named: "back")
        }

        enum shortDescription {
            static let workLogo = UIImage(named: "workLogo")
            static let studyLogo = UIImage(named: "studyLogo")
            static let brownWorkLogo = UIImage(named: "brownWorkLogo")
            static let blackStudyLogo = UIImage(named: "blackStudyLogo")
            static let locationLogo = UIImage(named: "location")
        }
    }
}
