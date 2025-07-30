//
//  MockDashboardViewModel.swift
//  Feature
//
//  Created by david.santiago on 30/07/25.
//
import Feature
import UIModule
import Utils
import Combine

final class MockDashboardViewModel: DashboardViewModelProtocol {
    
    public var fetchTransactionsCalled = false
    @Published var transaction: Transaction? = nil

    func fetchTransactions() {
        fetchTransactionsCalled = true
    }
}
