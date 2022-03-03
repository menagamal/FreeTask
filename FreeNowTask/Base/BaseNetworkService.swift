//
//  BaseNetworkService.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import Foundation
import Moya
import RxSwift

class BaseNetworkService {
    func mapResult<T:Codable>(provider: MoyaProvider<MultiTarget>, target: MultiTarget) -> Observable<Result<T?, NetworkServiceErrors>> {
        Observable.create { observer in
            self.mapResult(provider: provider, target: target) { (result: Result<T?, NetworkServiceErrors>) in
                observer.onNext(result)
            }
            return Disposables.create()
        }
    }
    
    private func mapResult<T:Codable>(provider: MoyaProvider<MultiTarget>, target: MultiTarget, completion: @escaping (Result<T?, NetworkServiceErrors>) -> Void) {
        provider.request(target.debugLog()) { result in
            switch result {
            case .success(let response):
                do {
                    switch response.statusCode {
                    case 200...301:
                        let decodableResponse = try response.debugLog().map(T.self)
                        completion(.success(decodableResponse))
                    case 404:
                        completion(.failure(.NotFound))
                    default:
                        completion(.failure(.ParsingError))
                    }
                } catch {
                    completion(.failure(.ParsingError))
                }
            case .failure(let error):
                completion(.failure(.NetworkError(message: error.localizedDescription)))
            }
        }
    }
}

enum NetworkServiceErrors: Error {
    case ParsingError, NetworkError(message: String), NotFound
    
    var customMessage: String {
        switch self {
        case .ParsingError:
            return "Something Went wrong while getting response"
        case .NetworkError(let message):
            return message
        case .NotFound:
            return "Server is not found"
        }
    }
}
