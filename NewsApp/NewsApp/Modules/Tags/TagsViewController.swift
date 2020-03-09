//
//  TagsViewController.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TagsViewController: BaseViewController, BindableType {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    // MARK: - Dependencies
       var viewModel: TagsViewModelType!
       private let disposeBag = DisposeBag()
    
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
            .bind(to: collectionView.rx.items(cellIdentifier: TagCell.typeName, cellType: TagCell.self)) { item, data, cell in
                cell.bind(to: data)
        }.disposed(by: disposeBag)
        
        doneButton.rx.tap.bind(to: viewModel.input.didTapDone).disposed(by: disposeBag)
        
        viewModel.output.errorMessage
        .subscribe(onNext: {
            self.showErrorMessage(text: $0)
        }).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TagViewModel.self)
        .bind(to: viewModel.input.selectCategory)
        .disposed(by: disposeBag)

        
//        collectionView.rx.modelSelected(CountryViewModel.self)
//            .bind(to: viewModel.input.selectedCountry)
//            .disposed(by: disposeBag)
//
//        collectionView.rx.modelDeselected(CountryViewModel.self)
//            .bind(to: viewModel.input.deselectedCountry)
//            .disposed(by: disposeBag)
//
//        nextButton.rx.tap.bind(to: viewModel.input.didTapNext).disposed(by: disposeBag)
//
//        viewModel.output.errorMessage
//        .subscribe(onNext: {
//            self.showErrorMessage(text: $0)
//        }).disposed(by: disposeBag)
    }
    
    private func registerCell() {
        let tagCell = UINib(nibName: TagCell.typeName, bundle: nil)
        collectionView.register(tagCell, forCellWithReuseIdentifier: TagCell.typeName)
    }

    private func configureCollectionView() {
        registerCell()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let itemWidth = collectionView.bounds.width/4
        let itemHeight = collectionView.bounds.height / 6
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
}
