//
//  MockDashboardView.swift
//  Feature
//
//  Created by david.santiago on 30/07/25.
//
import UIModule
import Foundation
import UIKit
import Utils

final class MockDashboardView: UIView, DashboardViewProtocol {
    var tableView = UITableView()
    var transactions: [TransactionDetail] = []
    var hideAmountSwitch = UISwitch()

    var updateMetadataCalled = false
    var receivedTransaction: Transaction?
    var updateAmountVisibilityCalled = false

    func updateMetadata(metadata: Transaction?) {
        updateMetadataCalled = true
        receivedTransaction = metadata
    }

    func updateAmountVisibility(hide: Bool) {
        updateAmountVisibilityCalled = true
    }
}
