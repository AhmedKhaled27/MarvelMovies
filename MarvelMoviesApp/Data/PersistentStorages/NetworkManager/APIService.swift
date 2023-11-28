//
//  APIService.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation
import Moya

public class APIService<T> where T: TargetType {
    // MARK: - Attributes
    private let provider: MoyaProvider<T>
    
    private let jsonDataFormatter = { (_ data: Data) -> String  in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    private let endpointClosure = { (target: T) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        var request = try? defaultEndpoint.urlRequest()
        request?.cachePolicy = .useProtocolCachePolicy
        debugPrint(request?.urlRequest?.url ?? "")
        return defaultEndpoint
    }
    
    // MARK: Init
    init() {
        provider = MoyaProvider<T>()
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 20
        provider.session.sessionConfiguration.timeoutIntervalForResource = 20
    }
    
    func request<C: Codable>(target: T, objType: C.Type, completionHandler:  @escaping (_ result: Result<C, Error>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let successResponse = try response.filterSuccessfulStatusCodes()
                    let object = try JSONDecoder().decode(objType, from: successResponse.data)
                    completionHandler(.success(object))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
