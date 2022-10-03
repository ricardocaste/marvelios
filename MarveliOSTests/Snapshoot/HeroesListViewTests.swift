//
//  HeroesListViewTest.swift
//  MarveliOSTests
//
//  Created by Ricardo Castellanos on 20/9/22.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import MarveliOS

class HeroListViewTests: XCTestCase {
    
    let trait = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)

    override func setUp() {
    }

    override func tearDown(){
    }

//    @MainActor
//    func testLoadingView() throws {
//        let viewModel = HeroesViewModel(repository: DependencyInjector.getHeroesRepository())
//        viewModel.heroes = [Hero.random]
//        let mockHeroRow = HeroesListView(viewmodel: viewModel)
//        let vc = UIHostingController(rootView: mockHeroRow)
//        assertSnapshot(matching: vc, as: .image(on: .iPhone8), record: true)
//    }
//
//    @MainActor
//    func testListView() throws {
//        let viewModel = HeroesViewModel(repository: DependencyInjector.getHeroesRepository())
//        let mockHeroRow = HeroesListView(viewmodel: viewModel)
//        let viewController = UIHostingController(rootView: mockHeroRow)
//        viewModel.isLoading = false
//        viewModel.viewModelError = nil
//        viewModel.heroes = [Hero.random]
//        assertSnapshot(matching: viewController, as: .image(layout: .device(config: .iPhoneX), traits: trait), record: true)
//    }
//
//    @MainActor
//    func testEmptyView() throws {
//        let viewModel = HeroesViewModel(repository: DependencyInjector.getHeroesRepository())
//        let mockHeroRow = HeroesListView(viewmodel: viewModel)
//        let viewController = UIHostingController(rootView: EmptyView())
//        viewModel.heroes = []
//        viewModel.isLoading = false
//        assertSnapshot(matching: viewController, as: .image(layout: .device(config: .iPhoneX), traits: trait), record: true)
//    }

}
