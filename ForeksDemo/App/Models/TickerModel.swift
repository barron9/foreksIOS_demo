
import Foundation

public struct TickerModel :Decodable{
    let clo: String
    let las: String
    let pdd: String
    let tke: String

}

extension TickerModel {
    init(tm: TickerModel) {
        self.clo = tm.clo
        self.las = tm.las
        self.pdd = tm.pdd
        self.tke = tm.tke
  
    }
}
