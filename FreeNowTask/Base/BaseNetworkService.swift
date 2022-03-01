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
    let provider: MoyaProvider<MultiTarget>

    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    func mapResult<T:Codable>(target: MultiTarget) -> Observable<Result<T?, NetworkServiceErrors>> {
        Observable.create { observer in
            self.mapResult(target: target) { (result: Result<T?, NetworkServiceErrors>) in
                observer.onNext(result)
            }
            return Disposables.create()
        }
    }
    
    private func mapResult<T:Codable>(target: MultiTarget, completion: @escaping (Result<T?, NetworkServiceErrors>) -> Void) {
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
}
