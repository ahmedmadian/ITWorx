//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ArticlesViewController: BaseViewController, BindableType {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Dependencies
    var viewModel: ArticlesViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifTableView()
    }
    
    // MARK: - Method
    func bindViewModel() {
        
        //Inputs
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .map { _ in }
            .bind(to: viewModel.input.viewLoaded)
            .disposed(by: disposeBag)
        
        viewModel.output.data
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: ArticleCell.typeName, cellType: ArticleCell.self)) { item, data, cell in
                cell.delegate = self
                cell.configCellAppearnce(with: data)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ArticleViewModel.self)
            .bind(to: viewModel.input.articleSelected)
            .disposed(by: disposeBag)
        viewModel.output.loading.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
        
        viewModel.output.errorMessage
        .subscribe(onNext: {
            self.showErrorMessage(text: $0)
        }).disposed(by: disposeBag)
    }
    
    private func congifTableView() {
        let itemNib = UINib(nibName: ArticleCell.typeName, bundle: nil)
        tableView.register(itemNib, forCellReuseIdentifier: ArticleCell.typeName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
    }
}


extension ArticlesViewController: FavoriteArticleDelegate {
    func saveArticle(model: ArticleViewModel) {
        viewModel.input.saveArticle.on(.next(model))
    }
    
    func removeArticle(model: ArticleViewModel) {
        viewModel.input.removeArticle.on(.next(model))
    }
    
    
}
