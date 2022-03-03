//
//  NetworkMock.swift
//  FreeNowTaskTests
//
//  Created by Mena Gamal on 03/03/2022.
//

import Foundation
import RxSwift
@testable import FreeNowTask

class NetworkSuccessMock: ListVehiclesServicesUseCase {
    func getVehicleData(p1Lat: Double, p1Lon: Double, p2Lat: Double, p2Lon: Double) -> Observable<Result<ListVehicleResponse?, NetworkServiceErrors>> {
        let result: Result<ListVehicleResponse?, NetworkServiceErrors> = .success(constructListVehicleResponse())
        return Observable.just(result)
    }
    
    private func constructListVehicleResponse() -> ListVehicleResponse {
        let array = [PoiList(id: 0,
                             coordinate: Coordinate(latitude: 0.0, longitude: 0.0),
                             state: .active,
                             type: .taxi,
                             heading: 0)]
        return ListVehicleResponse(poiList: array)
    }
}
