//
//  ListVehicleViewModel.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import Foundation
import RxSwift

class ListVehicleViewModel {
    private var service: ListVehiclesServicesUseCase
    private let P1_LAT = 53.694865
    private let P2_LAT = 53.394655
    private let P1_LON = 9.757589
    private let P2_LON = 10.099891
    
    // MARK: OUTPUT
    var polist: Observable<[PoiList]>?
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    init(service: ListVehiclesServicesUseCase) {
        self.service = service
    }

    func fetchListData() {
        isLoading.onNext(true)
        polist = service.getVehicleData(p1Lat: P1_LAT, p1Lon: P1_LON, p2Lat: P2_LAT, p2Lon: P2_LON).map({
            return try $0.get()?.poiList ?? []
        }).do(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.onNext(false)
        })
    }
}
