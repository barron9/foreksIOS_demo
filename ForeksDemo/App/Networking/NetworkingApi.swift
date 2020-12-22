
import Foundation


protocol NetworkingService {
    @discardableResult func pingTickers(withQuery query: String, completion: @escaping ([TickerModel]) -> ()) ->URLSessionDataTask
    @discardableResult func pullSettings(completion: @escaping ([SettingsModel]) -> ()) ->URLSessionDataTask

}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared
    
    @discardableResult
    func pullSettings(completion: @escaping ([SettingsModel]) -> ()) -> URLSessionDataTask {
        var request = URLRequest(url: URL(string: "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/ForeksMobileInterviewSettings")!)
        request.httpMethod="GET"
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(sResponse.self, from: data) else {
                        print("data fail")
                        return
                }
                print(response)
                
                completion(response.mypageDefaults)
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func pingTickers(withQuery query: String, completion: @escaping ([TickerModel]) -> ()) -> URLSessionDataTask {
        var request = URLRequest(url: URL(string: "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/ForeksMobileInterview?fields=pdd,las&stcs=\(query)")!)
        request.httpMethod="GET"
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                    let response = try? JSONDecoder().decode(tResponse.self, from: data) else {
                    print("devoce fail")
                        completion([])
                        return
                }
                print(response)
                completion(response.l)
            }
        }
        task.resume()
        return task
    }
    
}
fileprivate struct sResponse: Decodable {
    let mypageDefaults: [SettingsModel]
 
}

fileprivate struct tResponse: Decodable {
    let l: [TickerModel]
}
