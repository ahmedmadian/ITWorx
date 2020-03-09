//
//  TagsViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

class TagsViewModel: TagsViewModelType, TagsViewModelInput, TagsViewModelOutput {
    
    // MARK: - INPUTS
    var viewLoaded: PublishSubject<Void>
    var didTapDone: PublishSubject<Void>
    var selectCategory: PublishSubject<TagViewModel>

    // MARK: - OUTPUTS
    var data: Observable<[TagViewModel]>
    var errorMessage: PublishSubject<String>
    
    // MARK: - DEPENDENCIES
       private let startupRouter: UnownedRouter<AppStartupRoute>?
       private let settingsRouter: UnownedRouter<SettingsRoute>?
    
    init(startupRouter: UnownedRouter<AppStartupRoute>?, settingsRouter: UnownedRouter<SettingsRoute>?) {
        
        /// init DEPENDENCIES
        self.startupRouter = startupRouter
        self.settingsRouter = settingsRouter
        
        /// init INPUTS
        viewLoaded = PublishSubject<Void>().asObserver()
        self.didTapDone = PublishSubject<Void>().asObserver()
        self.selectCategory = PublishSubject<TagViewModel>().asObserver()
        
        /// init OUTPUTS
        errorMessage = PublishSubject<String>()
        let loadedData = Tag.dummyTags().map { tag -> TagViewModel in
            let items = Settings.shared.categories
            let viewModel = TagViewModel(with: tag)
            viewModel.isSelected.accept(items?.contains(tag.name) ?? false)
            return viewModel
        }
        self.data = Observable.of(loadedData)
        
        _ = selectCategory.subscribe(onNext: {
            $0.isSelected.accept(!$0.isSelected.value)
        })
        
        _ = didTapDone.subscribe(onNext: {
            let selectedTags = loadedData.filter {$0.isSelected.value}
            if selectedTags.count != 3 {
                self.errorMessage.onNext("Please Select 3 Categories Only")
                return
            }
            if Settings.shared.countryName == nil {
                self.errorMessage.onNext("PLEASE SELECT COUNTRY")
                return
            }
            Settings.shared.categories = selectedTags.map{$0.title}
            if let startuprRouter = startupRouter {
                Settings.shared.launchedBefore = true
                startuprRouter.trigger(.home)
            }
            if let router = settingsRouter {
                router.trigger(.exit)
            }
        })
        
    }
    
    
}
