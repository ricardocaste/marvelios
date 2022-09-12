//
//  HeroesViewModel.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 8/3/22.
//

import Foundation
import SwiftUI

// Marked as main actor because is attach to the view, an actor execute actions in the main thread
@MainActor
class HeroesViewModel: BaseViewModel {
    
    var repository: HeroesRepository
    var page: Int = 0

    /// Number of heroes the API would return
    var limit: Int { 10 }

    /// Parameter required for pagination in order to retrieve heroes
    var offset: Int = 0

    /// For getting next X = limit results
    var nextOffset: Int { result.count + limit }

    /// Prevent requesting heroes when coming back from detailed view
    var comingFromDetailView: Bool = false

    var result: [Hero] = [] {
        didSet {
            withAnimation {
                heroes = result
            }
        }
    }

    var filteredResults: [Hero] = [] {
        didSet {
            withAnimation {
                if !filteredResults.isEmpty {
                    heroes = filteredResults
                } else {
                    heroes = result
                }
            }
        }
    }

    @Published var heroes: [Hero] = []
    @Published var viewModelError: HeroesViewModelError?
    @Published var isLoading: Bool = true

    required init(repository: HeroesRepository = DependencyInjector.getHeroesRepository()) {
        self.repository = repository
    }

    // MARK: get heroes

    func getHeroes(isRefreshing: Bool = false) async {
        cleanErrors()
        do {
            guard !comingFromDetailView || isRefreshing else {
                self.comingFromDetailView.toggle()
                return
            }

            withAnimation {
                isLoading = true
            }
            page += 1
            let newResult = try await repository.getHeroes(limit: limit,
                                                           page: page,
                                                           offset: nextOffset)

            withAnimation {
                isLoading = false
            }

            result += newResult

        } catch ApiError.offline {
            self.viewModelError = .notConnectedToInternet
            self.isLoading = false
        } catch {
            self.viewModelError = .couldNotUpdateHeroe
            self.isLoading = false
        }
    }

    // MARK: ViewHelpers

    func canTriggerPagination(for hero: Hero) -> Bool {
        return result.count > 0 &&
        filteredResults.isEmpty &&
        result.last == hero ? true : false
    }

    func togglePagination() async {
        if result.count > limit - 1 {
            do {
                page += 1
                let newResult = try await repository.getHeroes(limit: limit, page: page, offset: nextOffset)
                result += newResult
            } catch ApiError.offline {
                self.viewModelError = .notConnectedToInternet
                self.isLoading = false
            } catch {
                self.isLoading = false

                // When a Task is cancelled
                guard (error as NSError?)?.code == NSURLErrorCancelled  else {
                    self.viewModelError = .unknown
                    return
                }
            }
        }
    }

    func triggerSearch(for query: String) {
        if query == "" {
            filteredResults = []
        } else {
            filteredResults = result.filter {
                $0.name.lowercased().contains(query.lowercased()) || $0.description.lowercased().contains(query.lowercased())
            }
        }
    }

    func cleanErrors() {
        self.viewModelError = nil
    }

    func goingToDetailView() {
        comingFromDetailView = true
    }
}
