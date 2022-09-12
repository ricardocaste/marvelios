//
//  BaseViewModel.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation

@MainActor
protocol BaseViewModel: ObservableObject {
    associatedtype Entity
    associatedtype ErrorType
    associatedtype Repo
    var result: [Entity] { get set }
    var viewModelError: ErrorType? { get set }
    var repository: Repo { get set }

    init(repository: Repo)
}
