//
//  NetworkFailedMock.swift
//  FreeNowTaskTests
//
//  Created by Mena Gamal on 03/03/2022.
//

import Foundation
import RxSwift
@testable import FreeNowTask

class NetworkFailedMock: ListVehiclesServicesUseCase {
    private var customError: NetworkServiceErrors = .NotFound
    func getVehicleData(p1Lat: Double, p1Lon: Double, p2Lat: Double, p2Lon: Double) -> Observable<Result<ListVehicleResponse?, NetworkServiceErrors>> {
        let result: Result<ListVehicleResponse?, NetworkServiceErrors> = .failure(customError)
        return Observable.just(result)
    }
    func setCustomError(customError: NetworkServiceErrors) {
        self.customError = customError
    }
}
