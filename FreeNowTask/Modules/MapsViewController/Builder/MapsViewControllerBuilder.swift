//
//  MapsViewControllerBuilder.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 02/03/2022.
//

import Foundation
import UIKit

class MapsViewControllerBuilder {
    func instantiate(polist: [PoiList]) -> MapsViewController {
        let vc: MapsViewController = UIViewController.instanceXib()
        let viewModel = MapsViewModel(polist: polist)
        vc.viewModel = viewModel
        return vc
        
    }
}
