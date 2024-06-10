import Foundation

class AuthRepository {
    private let localService: LocalUserService
    private let remoteService: RemoteUserService

    init(localService: LocalUserService, remoteService: RemoteUserService) {
        self.localService = localService
        self.remoteService = remoteService
    }
}
