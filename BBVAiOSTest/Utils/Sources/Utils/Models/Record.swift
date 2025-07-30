//
//  Record.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//

import Foundation

public struct Record: Decodable {
    public let balance: CGFloat
    public let transactions: [TransactionDetail]
    
    public init(balance: CGFloat, transactions: [TransactionDetail]) {
        self.balance = balance
        self.transactions = transactions
    }
}
