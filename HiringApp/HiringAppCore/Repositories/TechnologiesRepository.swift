import Foundation
import Deferred

public protocol TechnologiesRepositoryProtocol {
    func retrieveTechnologiesList() -> Task<[TechnologyModel]>
}

public class TechnologiesRepository {
    
    //MARK: - Stored properties
    fileprivate let apiProvider: APIProviderProtocol
    
    //MARK: - Initializer
    public init(apiProvider: APIProviderProtocol = APIProvider.provider) {
        self.apiProvider = apiProvider
    }
}

extension TechnologiesRepository: TechnologiesRepositoryProtocol {
    
    public func retrieveTechnologiesList() -> Task<[TechnologyModel]> {
    
        return apiProvider.retrieveTechnologiesList()
    }
}
