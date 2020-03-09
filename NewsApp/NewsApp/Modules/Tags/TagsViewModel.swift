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
    
    
    
    
    
    var viewLoaded: PublishSubject<Void>
    var didTapDone: PublishSubject<Void>
    var selectCategory: PublishSubject<TagViewModel>

    
    var data: Observable<[TagViewModel]>
    var errorMessage: PublishSubject<String>
    
    
    // MARK: - Dependancies
       private let startupRouter: UnownedRouter<AppStartupRoute>?
       private let settingsRouter: UnownedRouter<SettingsRoute>?
    
    init(startupRouter: UnownedRouter<AppStartupRoute>?, settingsRouter: UnownedRouter<SettingsRoute>?) {
        
        self.startupRouter = startupRouter
        self.settingsRouter = settingsRouter
        
        viewLoaded = PublishSubject<Void>().asObserver()
        self.didTapDone = PublishSubject<Void>().asObserver()
        self.selectCategory = PublishSubject<TagViewModel>().asObserver()
        
        errorMessage = PublishSubject<String>()
        
        let loadedData = Tag.dummyTags().map{TagViewModel(with: $0)}
        self.data = Observable.of(loadedData)
//        self.data = viewLoaded.flatMapLatest({ _ -> Observable<[TagViewModel]> in
//            let res = Tag.dummyTags().map {$0.map {TagViewModel(with: $0)}}
//            return res
//        })
        
        
        
        _ = selectCategory.subscribe(onNext: {
            $0.isSelected.accept(!$0.isSelected.value)
            //Settings.shared.categories.append($0.title)
        })
        
        _ = didTapDone.subscribe(onNext: {
            let selectedTags = loadedData.filter {$0.isSelected.value}
            if selectedTags.count < 3 {
                self.errorMessage.onNext("PLEASE Select 3 Categories at least")
                return
            }
            if Settings.shared.countryName == nil {
                self.errorMessage.onNext("PLEASE SELECT COUNTRY")
                return
            }
            Settings.shared.categories = selectedTags.map{$0.title}
            if let startuprRouter = startupRouter {
                startuprRouter.trigger(.home)
            }
        })
        
    }
    
    
}
