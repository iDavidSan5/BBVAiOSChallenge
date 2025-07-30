//
//  DashboardViewControllerTest.swift
//  Feature
//
//  Created by david.santiago on 30/07/25.
//

import XCTest
import Combine
import Utils
import UIModule
@testable import Feature

final class DashboardViewControllerTests: XCTestCase {
    
    @MainActor
    func testFetchTransactionsIsCalled() {
        let mockViewModel = MockDashboardViewModel()
        let sut = DashboardViewController(viewModel: mockViewModel)
        
        sut.loadViewIfNeeded()
        mockViewModel.fetchTransactions()

        XCTAssertTrue(mockViewModel.fetchTransactionsCalled)
    }

    @MainActor
    func testSetupHideAmountSwitchAddsTarget() {
        let viewModelMock = MockDashboardViewModel()
        let sut = DashboardViewController(viewModel: viewModelMock)
        sut.loadViewIfNeeded()

        sut.setupHideAmountSwitch()

        let switchControl = sut.dashboardView
        let targets = switchControl.hideAmountSwitch.allTargets

        XCTAssertNotNil(targets)
        XCTAssertTrue(targets.contains(sut))

        let actions = switchControl.hideAmountSwitch.actions(forTarget: sut, forControlEvent: .valueChanged)
        XCTAssertTrue(actions?.contains("switchToggled:") ?? false)
    }
}
