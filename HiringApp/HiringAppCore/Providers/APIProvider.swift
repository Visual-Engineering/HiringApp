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
import KeychainSwift

enum APIError: Error {
    case badStatusCode(errorCode: Int)
    case errorWhileParsing
    case responseUnexpected
}

protocol DroskyType {
    func performRequest(forEndpoint endpoint: Endpoint) -> Task<DroskyResponse>
}

extension Drosky: DroskyType {}

public protocol APIProviderType {
    func retrieveTechnologies() -> Task<[TechnologyModel]>
    func retrieveTopics(technologyId: Int) -> Task<[TopicModel]>
    func performContact(candidate: CandidateModel) -> Task<Data>
}

class APIProvider: APIProviderType {
    
    let drosky: DroskyType
    
    init(drosky: DroskyType = Drosky(environment: EnvironmentType.development)) {
        self.drosky = drosky
    }
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        let statusCodeTask = performRequest(endpoint: AppEndpoints.technologies)
        let modelTask: Task<[TechnologyModel]> = statusCodeTask.andThen(upon: .global(), start: parse)
        return modelTask
    }
    
    func performLogin(deviceID: String) -> Task<String> {
        let statusCodeTask = performRequest(endpoint: AppEndpoints.authenticate(deviceID: deviceID))
        let modelTask = statusCodeTask.andThen(upon: .global()) { (data) -> Task<String> in
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>,
                let token = json["authToken"] as? String else {
                    return Task(failure: APIError.errorWhileParsing)
            }
            let keychain = KeychainSwift()
            keychain.set(token, forKey: "userToken")
            return Task(success: token)
        }
        return modelTask
    }
    
    
    func performContact(candidate: CandidateModel) -> Task<(Data)> {
        let statusCodeTask = performRequest(endpoint: AppEndpoints.candidate(parameters: candidate.dict as [String : AnyObject]))
        return statusCodeTask
    }
    
    func retrieveTopics(technologyId: Int) -> Task<[TopicModel]> {
        let statusCodeTask = performRequest(endpoint: AppEndpoints.topics(technologyId: technologyId))
        let modelTask: Task<[TopicModel]> = statusCodeTask.andThen(upon: .global(), start: parse)
        return modelTask
    }
    
    func performRequest(endpoint: Endpoint) -> Task<Data> {
        //perform a request
        let droskyTask = drosky.performRequest(forEndpoint: endpoint)
        
        //check the status code of the response
        let statusCodeTask = droskyTask.andThen(upon: .global(), start: checkStatusCode)
        return statusCodeTask
    }
    
    func checkStatusCode(fromDroskyResponse droskyResponse: DroskyResponse) -> Task<Data> {
        //Check if status code is in range od 200s
        guard droskyResponse.statusCode >= 200 && droskyResponse.statusCode < 300 else {
            return Task(failure: APIError.badStatusCode(errorCode: droskyResponse.statusCode))
        }
        
        return Task(success: droskyResponse.data)
    }
    
    func parse<T:Decodable>(data: Data) -> Task<T> {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? T.decode(json) else {
                return Task(failure: APIError.errorWhileParsing)
        }
        return Task(success: data)
    }
    
    func parse<T: Decodable>(data: Data) -> Task<[T]> {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? [T].decode(json) else {
                return Task(failure: APIError.errorWhileParsing)
        }
        return Task(success: data)
    }
}
