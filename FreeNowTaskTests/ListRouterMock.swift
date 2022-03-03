//
//  ListRouterMock.swift
//  FreeNowTaskTests
//
//  Created by Mena Gamal on 03/03/2022.
//

import Foundation
import UIKit
@testable import FreeNowTask

class ListRouterMock: ListRouter {
    var rootViewController: UIViewController?
    var didOpenMapsScreen = false
    var didOpenMapsScreenWithOneLocation = false
    
    func present(to destination: ListRouterImp.Destination) {
        handleDestination(destination: destination)
    }
    
    func navigate(to destination: ListRouterImp.Destination) {
        handleDestination(destination: destination)
    }

    private func handleDestination(destination: ListRouterImp.Destination) {
        switch destination {
        case .showOnMap(_):
            self.didOpenMapsScreenWithOneLocation = true
            self.didOpenMapsScreen = false
        case .openMaps(_):
            self.didOpenMapsScreen = true
            self.didOpenMapsScreenWithOneLocation = false
        }
    }
}
