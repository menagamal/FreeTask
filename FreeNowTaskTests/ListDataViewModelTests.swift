//
//  ListDataViewModelTests.swift
//  FreeNowTaskTests
//
//  Created by Mena Gamal on 03/03/2022.
//

import XCTest
@testable import FreeNowTask

class ListDataViewModelTests: XCTestCase {

    var viewModel: ListVehicleViewModel!
    var successMock = NetworkSuccessMock()
    var failedMock = NetworkFailedMock()
    var router = ListRouterMock()
    
    override func setUp() {
        viewModel = ListVehicleViewModel(service: successMock, router: router)
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testIsLoadingBeforeCall() {
        viewModel.fetchListData()
        let exp = expectation(description: #function)
        
        var loadingValue: Bool = false
        let subscription = viewModel.isLoading
            .subscribe(onNext: {
                loadingValue = $0
            })
        defer { subscription.dispose() }
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(loadingValue)
        } else {
            XCTFail("time out")
        }
    }
    
    func testIsPolistLoaded() {
        viewModel.fetchListData()
        let exp = expectation(description: #function)
        
        var polist: [PoiList] = []
        let subscription = viewModel.polist?
            .subscribe(onNext: {
                polist = $0
            })
        defer { subscription?.dispose() }

        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(polist.count, 1)
        } else {
            XCTFail("time out")
        }
    }
    
    func testNetworkCall() {
        let expected = "Network message"
        failedMock.setCustomError(customError: .NetworkError(message: expected))
        viewModel = ListVehicleViewModel(service: failedMock, router: router)
        viewModel.fetchListData()
        let exp = expectation(description: #function)
        
        var errorMessage: String = ""
        let subscription = viewModel.error?
            .subscribe(onNext: {
                errorMessage = $0
            })
        defer { subscription?.dispose() }

        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorMessage, expected)
        } else {
            XCTFail("time out")
        }
    }
    
    func testNotFound() {
        failedMock.setCustomError(customError: .NotFound)
        viewModel = ListVehicleViewModel(service: failedMock, router: router)
        viewModel.fetchListData()
        let exp = expectation(description: #function)
        
        var errorMessage: String = ""
        let subscription = viewModel.error?
            .subscribe(onNext: {
                errorMessage = $0
            })
        defer { subscription?.dispose() }

        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorMessage, "Server is not found")
        } else {
            XCTFail("time out")
        }
    }
    
    func testParsingError() {
        failedMock.setCustomError(customError: .ParsingError)
        viewModel = ListVehicleViewModel(service: failedMock, router: router)
        viewModel.fetchListData()
        let exp = expectation(description: #function)
        
        var errorMessage: String = ""
        let subscription = viewModel.error?
            .subscribe(onNext: {
                errorMessage = $0
            })
        defer { subscription?.dispose() }

        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(errorMessage, "Something Went wrong while getting response")
        } else {
            XCTFail("time out")
        }
    }
    
    func testNavigateToMaps() {
        viewModel = ListVehicleViewModel(service: successMock, router: router)
        viewModel.fetchListData()
        viewModel.navigateToMaps()
        XCTAssertTrue(router.didOpenMapsScreen)
    }
    
    func testNavigateToMapsWithOne() {
        viewModel = ListVehicleViewModel(service: successMock, router: router)
        
        viewModel.fetchListData()
        let exp = expectation(description: #function)
        
        let subscription = viewModel.polist?
            .subscribe(onNext: {
                self.viewModel.list = $0
            })
        defer { subscription?.dispose() }

        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            viewModel.navigateToMaps(with: 0)
            XCTAssertTrue(router.didOpenMapsScreenWithOneLocation)
        } else {
            XCTFail("time out")
        }
       
    }

}
