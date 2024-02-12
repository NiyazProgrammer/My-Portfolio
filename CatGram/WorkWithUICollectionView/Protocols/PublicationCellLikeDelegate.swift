import Foundation
protocol PublicationCellLikeDelegate: AnyObject {
    func toggleLike(publicationId: UUID)
    func didTapLikeButton()
}
