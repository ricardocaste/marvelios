//
//  HeroesListView.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import SwiftUI
import CoreData

struct HeroesListView: View {

    @StateObject var viewmodel = HeroesViewModel()

    @State var query: String = ""
    var body: some View {
            VStack {
                if viewmodel.heroes.count != 0 {
                    heroesView()
                } else {
                    emptyView()
                }
            }
            .loaderViewWrapper(isLoading: viewmodel.isLoading)
            .withErrorHandling(error: $viewmodel.viewModelError)
            .onDisappear { viewmodel.goingToDetailView() }
            .onAppear {
                Task {
                    await viewmodel.getHeroes()
                }
            }
    }

    func heroesView() -> some View {
        NavigationView {
            List {
                ForEach(viewmodel.heroes, id: \.id) { hero in
                    NavigationLink {
                        DetailView(hero: hero)
                    } label: {
                        HeroRow(hero: hero)
                            .accessibilityIdentifier(AccessibilityIdentifiers.characterListTableView)
                    }.task {
                        // Triggers pagination when reaching bottom
                        if viewmodel.canTriggerPagination(for: hero) {
                            await viewmodel.togglePagination()
                        }
                    }
                }
                    .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
            }.refreshable {
                await viewmodel.getHeroes(isRefreshing: true)
            }.navigationTitle("heroes".localized)
                .makeToolbarItems()
        }.navigationViewStyle(.stack)
        .searchable(text: $query) .onChange(of: query) { newQuery in
            viewmodel.triggerSearch(for: newQuery)
        }
    }

    func emptyView() -> some View {
        NavigationView {
            Button( action: {
                Task {
                    await viewmodel.getHeroes()
                }
            }, label: {
                Text("Get Heroes")
            }).buttonStyle(.borderedProminent)
                .controlSize(.large)
                .makeToolbarItems()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesListView(viewmodel: HeroesViewModel(repository: DependencyInjector.getHeroesRepository()))
            .preferredColorScheme(.light)
    }
}
