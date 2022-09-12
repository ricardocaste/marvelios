//
//  DetailViewModel.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 7/9/22.
//

import Foundation
import Combine
import SwiftUI

// Marked as main actor because is attach to the view, an actor execute actions in the main thread
@MainActor
class DetailViewModel: BaseViewModel {    

    var repository: ComicsRepository

    let didLoad = PassthroughSubject<DetailViewModel, ApiError>()
    
    @Published var result: [ComicHero] = [] {
        didSet {
            withAnimation {
                //comics = result
                didLoad.send(self)
            }
        }
    }
    
    @Published var viewModelError: DetailViewModelError?

    required init(repository: ComicsRepository = DependencyInjector.getComicsRepository()) {
        self.repository = repository
    }

    // MARK: CRUD Methods

    func getComics(name: String = "") async {
        cleanErrors()
        do {
            let newResult = try await repository.getComics(name: name)
            result = newResult
        } catch ApiError.offline {
            self.viewModelError = .notConnectedToInternet
        } catch {
            self.viewModelError = .unknown
        }
    }

    func cleanErrors() {
        self.viewModelError = nil
    }
}
