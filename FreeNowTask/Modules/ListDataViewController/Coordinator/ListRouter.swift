//
//  ListRouter.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 02/03/2022.
//

import Foundation
import UIKit
import MapKit

protocol ListRouter: AnyObject {
    var rootViewController: UIViewController? { get set }
    func present(to destination: ListRouterImp.Destination)
    func navigate(to destination: ListRouterImp.Destination)
}

class ListRouterImp: ListRouter {
  
    enum Destination {
        case showOnMap(location: PoiList)
        case openMaps(polist: [PoiList])
    }
    
    internal weak var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func navigate(to destination: ListRouterImp.Destination) {
        if let viewController = makeViewController(for: destination) {
            rootViewController?.show(viewController, sender: rootViewController)
        }
    }
    
    func present(to destination: ListRouterImp.Destination) {
        if let viewController = makeViewController(for: destination) {
            rootViewController?.present(viewController, animated: true)
        }
    }
}
private extension ListRouterImp {
    
    func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
        case .showOnMap(let location):
            return MapsViewControllerBuilder().instantiate(polist: [location])
        case .openMaps(let polist):
            return MapsViewControllerBuilder().instantiate(polist: polist)
        }
    }
}


