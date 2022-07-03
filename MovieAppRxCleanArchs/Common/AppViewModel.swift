//
//  ViewModelType.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 22/05/2022.
//

import UIKit

protocol ViewModelInput {}
protocol ViewModelOutput {}
protocol ViewModelDataSource {}

protocol AppViewModel {
    associatedtype Input: ViewModelInput
    associatedtype Output: ViewModelOutput
    associatedtype Coordinator: AppCoordinator
    
    var coordinator: Coordinator { get }

    func transform(input: Input) -> Output
}
