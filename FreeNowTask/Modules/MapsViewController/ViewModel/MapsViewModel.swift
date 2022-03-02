//
//  MapsViewModel.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 02/03/2022.
//

import Foundation
import RxSwift

class MapsViewModel {
    private var polist: [PoiList]
    var taxiMarkers = [TaxiAnotationModel]()
    init(polist: [PoiList]) {
        self.polist = polist
        loadTaxies()
    }
    
    private func loadTaxies() {
        for item in polist {
            taxiMarkers.append(TaxiAnotationModel(title: item.type.rawValue,
                                                  latitude: item.coordinate.latitude,
                                                  longitude: item.coordinate.longitude))
        }
    }
}
