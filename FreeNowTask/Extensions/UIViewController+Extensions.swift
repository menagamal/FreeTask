//
//  UIViewController+Extensions.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 02/03/2022.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    class func instanceXib<T: UIViewController>() -> T {
        return T(nibName: T.identifier, bundle: nil)
    }
}
