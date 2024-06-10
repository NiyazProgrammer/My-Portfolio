import Foundation
import UIKit

class SystemUICardsManager {

    let generalCardsMainProfile: [GeneralCardMainProfileView] = [
        GeneralCardMainProfileView(
            nameCard: Resources.Strings.GeneralCardsProfile.setting,
            imageCard: Resources.Images.GeneralCardsProfile.setting ?? UIImage(),
            colorLogo: Resources.Colors.GeneralCardsProfile.setting
        ),
        GeneralCardMainProfileView(
            nameCard: Resources.Strings.GeneralCardsProfile.favorites,
            imageCard: Resources.Images.GeneralCardsProfile.favorites ?? UIImage(),
            colorLogo: Resources.Colors.GeneralCardsProfile.favorites
        ),
        GeneralCardMainProfileView(
            nameCard: Resources.Strings.GeneralCardsProfile.notification,
            imageCard: Resources.Images.GeneralCardsProfile.notification ?? UIImage(),
            colorLogo: Resources.Colors.GeneralCardsProfile.notification
        )
    ]

    let securityCardsSetting: [SecurityCardSettingView] = [
        SecurityCardSettingView(
            cardName: Resources.Strings.SecurityCardsProfile.appsPassword,
            image: Resources.Images.SecurityCardsProfile.appsPassword ?? UIImage(),
            color: Resources.Colors.SecurityCardsSetting.appsPassword
        ),
        SecurityCardSettingView(
            cardName: Resources.Strings.SecurityCardsProfile.changePassword,
            image: Resources.Images.SecurityCardsProfile.changePassword ?? UIImage(),
            color: Resources.Colors.SecurityCardsSetting.changePassword
        ),
        SecurityCardSettingView(
            cardName: Resources.Strings.SecurityCardsProfile.notification,
            image: Resources.Images.SecurityCardsProfile.notification ?? UIImage(),
            color: Resources.Colors.SecurityCardsSetting.notification
        )
    ]

    let changeDataUsersCards: [ChangeDataUserCardView] = [
//    MARK: Временно убрал так как еще не реализовал функционал
//        ChangeDataUserCardView(
//            cardName: Resources.Strings.ChangeDataCards.TitleCard.lastName,
//            textPlaceholder: Resources.Strings.ChangeDataCards.PlaceholderCard.lastName),
//        ChangeDataUserCardView(
//            cardName: Resources.Strings.ChangeDataCards.TitleCard.firstName,
//            textPlaceholder: Resources.Strings.ChangeDataCards.PlaceholderCard.firstName
//        ),
//        ChangeDataUserCardView(
//            cardName: Resources.Strings.ChangeDataCards.TitleCard.middleName,
//            textPlaceholder: Resources.Strings.ChangeDataCards.PlaceholderCard.middleName
//        ),
        ChangeDataUserCardView(
            cardName: Resources.Strings.ChangeDataCards.TitleCard.nameUser,
            textPlaceholder: Resources.Strings.ChangeDataCards.PlaceholderCard.nameUser
        ),
        ChangeDataUserCardView(
            cardName: Resources.Strings.ChangeDataCards.TitleCard.email,
            textPlaceholder: Resources.Strings.ChangeDataCards.PlaceholderCard.email
        )
    ]

    let changePasswordUsersCards: [ChangePasswordCard] = [
        ChangePasswordCard(textPlaceholder: Resources.Strings.ChangePasswordCards.PlaceholderCard.currentPassword
        ),
        ChangePasswordCard(textPlaceholder: Resources.Strings.ChangePasswordCards.PlaceholderCard.newPassword
        ),
        ChangePasswordCard(textPlaceholder: Resources.Strings.ChangePasswordCards.PlaceholderCard.confirmNewPassword
        )
    ]
//    MARK: Временно убрал так как еще не реализовал функционал
//    var notifications: [Notification] = ["Push 1", "Push 2", "Push 3", "Push 4", "Push 5"].map { Notification(description: $0, image: nil, dateInfo: Date.now) }
}
