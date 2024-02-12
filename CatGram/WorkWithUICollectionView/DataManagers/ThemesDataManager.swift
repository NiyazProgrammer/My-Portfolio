import Foundation

class ThemesDataManager {
    private let themes: [String]?
    static var shared = ThemesDataManager()
    private init() {
        themes = ["Темная", "Светлая"]
    }
    func getThemesApp() -> [String] {
        themes ?? []
    }
}
