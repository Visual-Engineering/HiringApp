import Foundation
import Deferred
import Decodable

public protocol APIProviderProtocol {
    func retrieveTechnologiesList() -> Task<[TechnologyModel]>
}

public class APIProvider {
    
    //MARK: - Singleton
    public static let provider = APIProvider()
    private init() { }
}

extension APIProvider: APIProviderProtocol {
    
    public func retrieveTechnologiesList() -> Task<[TechnologyModel]> {
        
        guard let data = Bundle.jsonData(named: "results") else {
            return Task(failure: NSError(domain: String(describing: APIProvider.self), code: 0, userInfo: [
                NSLocalizedDescriptionKey : "Not found!"
                ]))
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let technologies = try? [TechnologyModel].decode(json) else {
                
                return Task(failure: NSError(domain: String(describing: APIProvider.self), code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Parser failed!"
                    ]))
        }
        return Task(success: technologies)
    }
}
