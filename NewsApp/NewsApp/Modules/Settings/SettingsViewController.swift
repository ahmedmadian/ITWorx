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
    @IBOutlet weak var countryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
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
        
        viewModel.output.selectedCountry.bind(to: countryLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
    }

}
