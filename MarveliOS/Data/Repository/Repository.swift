//
//  Repository.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation

protocol Repository {
    associatedtype Entity
    associatedtype Service

    var service: Service { get set }
    init(service: Service)
}
