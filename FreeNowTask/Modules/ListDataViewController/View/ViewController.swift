//
//  ListDataViewController.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ListDataViewController: UIViewController {

    @IBOutlet private weak var dataTableView: UITableView!

    private let disposeBag = DisposeBag()
    private var loadingIndicator: LoadingView?

    var viewModel: ListVehicleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = LoadingView(name: "loading", vc: self)
        setupTableView()
        viewModel?.fetchListData()
        bindUI()
        
    }
    
    private func setupTableView() {
        dataTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
    }

    private func bindUI() {
        viewModel?.isLoading.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if value {
                    self.loadingIndicator?.startLoading()
                } else {
                    self.loadingIndicator?.stopLoading()
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel?.polist?.bind(to: dataTableView.rx.items(cellIdentifier: "DataTableViewCell")) { index, model, cell in
            guard let cell = cell as? DataTableViewCell else { return  }
            cell.configure(title: model.type.rawValue, subTitle: model.state.rawValue)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
    }
}

