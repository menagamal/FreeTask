//
//  ListVehiclesServices.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import Foundation
import enum Moya.MultiTarget
import RxSwift

class ListVehiclesServices: BaseNetworkService {
    func getVehicleData(p1Lat: Double, p1Lon: Double, p2Lat: Double, p2Lon: Double) -> Observable<Result<ListVehicleResponse?, NetworkServiceErrors>>{
        return mapResult(
            target: MultiTarget(ApiTarget.listVehicleData(p1Lat: p1Lat,
                                                          p1Lon: p1Lon,
                                                          p2Lat: p2Lat,
                                                          p2Lon: p2Lon))
        )
    }
}
