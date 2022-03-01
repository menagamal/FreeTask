//
//  ListDataBuilder.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import Foundation
import UIKit
import Moya

class ListDataBuilder {
    func instantiate() -> UIViewController {
        let service = ListVehiclesServices()
        let viewModel = ListVehicleViewModel(service: service)
        let main = UIStoryboard(name: "Main", bundle: nil)
        if let vc = main.instantiateInitialViewController() as? ListDataViewController {
            vc.viewModel = viewModel
            return vc
        }
        return UIViewController()
    }
}
