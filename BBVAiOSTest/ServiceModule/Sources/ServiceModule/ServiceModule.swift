import Foundation
import Alamofire
import Swift

public class ServiceModule: NetworkServiceProtocol {
    private let bundle: Bundle

    public init() {
        self.bundle = Bundle.module
    }

    public func loadJSON<T: Decodable>(filename: String, as type: T.Type) -> T? {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}

