

import Foundation

final class ReposViewModel {
    // Outputs
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateRepos: (([SettingsModel]) -> Void)?
    var didUpdateTickers: (([TickerModel]) -> Void)?
    
    var didSelecteRepo: ((Int) -> Void)?
    var timer = Timer()
    private(set) var repos: [SettingsModel] = [SettingsModel]() {
        didSet {
            didUpdateRepos?(repos.map { SettingsModel(repo: $0) })
        }
    }
    private(set) var tickers: [TickerModel] = [TickerModel]() {
        didSet {
            didUpdateTickers?(tickers.map { TickerModel(tm: $0) })
        }
    }
    private var currentSearchNetworkTask: URLSessionDataTask?
    private var lastQuery: String?
    
    
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    func scstart(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)
    }
    
    @objc func refresh(){
        DispatchQueue.global(qos: .background).async {
            
            
            // DispatchQueue.main.async {
            self.isRefreshing?(true)
            self.networkingService.pullSettings() { [weak self] repos in
                //   guard let strongSelf  = self else { return }
                // strongSelf.finishSearching(with: repos)
                var req:[String] = []
                repos.forEach{
                    req.append($0.tke )
                    print("\($0.tke)")
                }
                print(req.joined(separator: "~"))
                self?.pingTickers(req: req.joined(separator: "~"))
            }
            // }
        }
    }
    
    func ready() {
        scstart()
    }
    func pingTickers(req:String) {
        isRefreshing?(true)
        networkingService.pingTickers(withQuery: req){ [weak self] repos in
            guard let strongSelf  = self else { return }
            strongSelf.finish(with: repos)
        }
    }
    
    private func finish(with tm: [TickerModel]) {
        isRefreshing?(false)
        self.tickers = tm
    }
}





