//
//  TagsViewModelProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TagsViewModelInput {
    var viewLoaded: PublishSubject<Void> { get }
    var didTapDone: PublishSubject<Void> { get }
    var selectCategory: PublishSubject<TagViewModel> { get }
}

protocol TagsViewModelOutput {
     var data: Observable<[TagViewModel]> {get}
    var errorMessage: PublishSubject<String> {get}
}

protocol TagsViewModelType {
    var input: TagsViewModelInput { get }
    var output: TagsViewModelOutput { get }
}

extension TagsViewModelType where Self: TagsViewModelInput & TagsViewModelOutput {
    var input: TagsViewModelInput { return self }
    var output: TagsViewModelOutput { return self }
}
