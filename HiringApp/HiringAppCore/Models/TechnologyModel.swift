import Foundation
import Decodable

public struct TechnologyModel {
    
    //MARK: - Stored properties
    public let id: Int
    public let title: String
    public let imageURL: String
    public let testAvailable: Bool
}

extension TechnologyModel: Decodable {
    public static func decode(_ json: Any) throws -> TechnologyModel {
        return try TechnologyModel(id: json => "id",
                                   title: json => "title",
                                   imageURL: json => "imageURL",
                                   testAvailable: json => "testAvailable")
    }
}

