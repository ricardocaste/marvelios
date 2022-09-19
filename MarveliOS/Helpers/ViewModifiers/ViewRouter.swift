//
//  ViewRouter.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 19/9/22.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "Home" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
