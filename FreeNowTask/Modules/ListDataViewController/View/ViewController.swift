//
//  ListDataViewController.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import UIKit
import RxSwift

class ListDataViewController: UIViewController {

    @IBOutlet private weak var dataTableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel: ListVehicleViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchListData()
        viewModel?.polist?.subscribe(onNext: { list in
            
        }, onError: { error in
            
        }).disposed(by: disposeBag)
        
    }


}

