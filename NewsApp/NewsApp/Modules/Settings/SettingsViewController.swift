//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsViewController: BaseViewController, BindableType {

    @IBOutlet weak var selectCountryButton: UIButton!
    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var prefrencesLabel: UILabel!
    
    // MARK: - Dependencies
    var viewModel: SettingsViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - Method
    func bindViewModel() {
        
        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .map { _ in }
            .bind(to: viewModel.input.viewLoaded)
            .disposed(by: disposeBag)
        
        selectCountryButton.rx.tap.bind(to: viewModel.input.didTapEditCountry).disposed(by: disposeBag)
        
        selectCategoryButton.rx.tap.bind(to: viewModel.input.didTapEditCategory).disposed(by: disposeBag)
        
        viewModel.output.selectedCountry.bind(to: countryLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.prefrences.bind(to: prefrencesLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
    }

}
