//
//  ListVehicleViewModel.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import Foundation
import RxSwift

class ListVehicleViewModel {
    private let service: ListVehiclesServicesUseCase
    private let router: ListRouter
    private let P1_LAT = 53.694865
    private let P2_LAT = 53.394655
    private let P1_LON = 9.757589
    private let P2_LON = 10.099891
    
    // MARK: OUTPUT
    var polist: Observable<[PoiList]>?
    var error: Observable<String>?
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var list = [PoiList]()
    init(service: ListVehiclesServicesUseCase, router: ListRouter) {
        self.service = service
        self.router = router
    }

    func fetchListData() {
        isLoading.onNext(true)
        let networkCall = service.getVehicleData(p1Lat: P1_LAT, p1Lon: P1_LON, p2Lat: P2_LAT, p2Lon: P2_LON)
        
        polist = networkCall.map({
            return try $0.get()?.poiList ?? []
        }).do(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.onNext(false)
        }).catchErrorJustReturn([])

        error = networkCall.compactMap({  (result) -> String in
            guard case let .failure(customError) = result else { return "" }
            return customError.customMessage
        })
    }
    
    func navigateToMaps() {
        router.navigate(to: .openMaps(polist: list))
    }
    
    func navigateToMaps(with index:Int) {
        if list.indices.contains(index) {
            router.navigate(to: .showOnMap(location: list[index]))
        }
    }
}
