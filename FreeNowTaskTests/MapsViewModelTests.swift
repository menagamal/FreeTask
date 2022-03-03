//
//  MapsViewModelTests.swift
//  FreeNowTaskTests
//
//  Created by Mena Gamal on 03/03/2022.
//

import Foundation

import XCTest
@testable import FreeNowTask

class MapsViewModelTests: XCTestCase {
    var viewModel: MapsViewModel!
    
    func testMarkersCreation() {
        viewModel = MapsViewModel(polist: [
            PoiList(id: 0,
                    coordinate: Coordinate(latitude: 0, longitude: 0),
                    state: .active,
                    type: .taxi,
                    heading: 0)]
        )
        XCTAssertEqual(viewModel.taxiMarkers.count, 1)
    }
}
