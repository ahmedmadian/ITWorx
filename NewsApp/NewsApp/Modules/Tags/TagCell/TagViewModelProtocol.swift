//
//  TagViewModelProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/9/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TagViewModelInput {
}

protocol TagViewModelOutput {
    var title: String {get}
    var isSelected: BehaviorRelay<Bool> {get}
}

protocol TagViewModelType {
    var input: TagViewModelInput { get }
    var output: TagViewModelOutput { get }
}

extension TagViewModelType where Self: TagViewModelInput & TagViewModelOutput {
    var input: TagViewModelInput { return self }
    var output: TagViewModelOutput { return self }
}
