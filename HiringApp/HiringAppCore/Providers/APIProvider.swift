//
//  APIProvider.swift
//  Pods
//
//  Created by Alba Luján on 21/6/17.
//
//

import Foundation
import BSWFoundation
import Deferred
import Decodable

enum APIError: Error {
    case badStatusCode
    case errorWhileParsing
}

struct DevelopmentEnvironment: Environment {
    var basePath: String {
        return "http://private-60454-visualtestapp.apiary-mock.com"
    }
}

struct TechologiesEndpoint: Endpoint {
    /// The path for the request
    var path: String { return "/technologies" }
}

protocol DroskyType {
    func performRequest(forEndpoint endpoint: Endpoint) -> Task<DroskyResponse>
}

extension Drosky: DroskyType {}

protocol APIProviderType {
    func retrieveTechnologies() -> Task<[TechnologyModel]>
}

class APIProvider: APIProviderType {
    
    let drosky: DroskyType
    
    init(drosky: DroskyType = Drosky(environment: DevelopmentEnvironment())) {
        self.drosky = drosky
    }
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        
        //perform a request
        let droskyTask = drosky.performRequest(forEndpoint: TechologiesEndpoint())
        
        //check the status code of the response
        let statusCodeTask = droskyTask.andThen(upon: .global()) { (droskyResponse) -> Task<Data> in
            //Check if status code is in range od 200s
            guard droskyResponse.statusCode >= 200 && droskyResponse.statusCode < 300 else {
                return Task(failure: APIError.badStatusCode)
            }
            
            return Task(success: droskyResponse.data)
        }
        
        //parse the data of the response and return a model
        let modelTask = statusCodeTask.andThen(upon: .global()) { (data) -> Task<[TechnologyModel]> in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let model = try [TechnologyModel].decode(json)
                return Task(success: model)
            } catch {
                return Task(failure: APIError.errorWhileParsing)
            }
        }
        return modelTask
    }
    
    
    
}
