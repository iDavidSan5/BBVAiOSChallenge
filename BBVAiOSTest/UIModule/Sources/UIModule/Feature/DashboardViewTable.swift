//
//  DashboarViewTable.swift
//  UIModule
//
//  Created by david.santiago on 29/07/25.
//
import Foundation
import UIKit
import Utils

extension DashboardView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionDetailCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateMetadata(metadata: self.transactions[indexPath.row], showAmount: hideAmountSwitch.isOn)
        cell.selectionStyle = .none
        return cell
    }
}
