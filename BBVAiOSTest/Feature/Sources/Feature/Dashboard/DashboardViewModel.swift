//
//  DashboardViewModel.swift
//  Feature
//
//  Created by david.santiago on 29/07/25.
//

import UIModule
import Utils
import ServiceModule
import Combine

@available(iOS 13.0, *)
public final class DashboardViewModel: DashboardViewModelProtocol {
    
    @Published public private(set) var transaction: Transaction?

    var hideAmounts: Bool {
        get { UserDefaultsManager.shared.hideAmounts }
        set { UserDefaultsManager.shared.hideAmounts = newValue }
    }
    
    private let service: NetworkServiceProtocol
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

    public init(service: NetworkServiceProtocol) {
        self.service = service
    }

    public func fetchTransactions() {
        if let data: Transaction = service.loadJSON(filename: "transactions", as: Transaction.self) {
            self.transaction = data
        } else {
            self.transaction = nil
        }
    }
}

