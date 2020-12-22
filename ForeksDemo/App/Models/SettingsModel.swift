import Foundation
public struct SettingsModel :Decodable {
    let cod: String
    let gro: String
    let tke: String
    let def: String

}

extension SettingsModel {
    init(repo: SettingsModel) {
        self.cod = repo.cod
        self.gro = repo.gro
        self.tke = repo.tke
        self.def = repo.def
    }
}
