//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavouritesViewController: BaseViewController, BindableType {

    // MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - DEPENDENCIES
    var viewModel: FavouritesViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        congifTableView()
    }
    
    // MARK: - METHODS
    func bindViewModel() {
        
        /// Inputs
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .map { _ in }
            .bind(to: viewModel.input.viewAppeared)
            .disposed(by: disposeBag)
        
        /// Outputs
        viewModel.output.data
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: FavouriteCell.typeName, cellType: FavouriteCell.self)) { item, data, cell in
                cell.configCellAppearnce(with: data)
        }.disposed(by: disposeBag)
        
    }
    
    private func congifTableView() {
        let itemNib = UINib(nibName: FavouriteCell.typeName, bundle: nil)
        tableView.register(itemNib, forCellReuseIdentifier: FavouriteCell.typeName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

}
