//
//  TransactionDetail.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//

import Foundation

public struct TransactionDetail: Decodable {
    public let id: Int
    public let name: String
    public let amount: CGFloat
    public let date: String
    public let type: TransactionDetailType
    
    public init(id: Int, name: String, amount: CGFloat, date: String, type: TransactionDetailType) {
        self.id = id
        self.name = name
        self.amount = amount
        self.date = date
        self.type = type
    }
}
