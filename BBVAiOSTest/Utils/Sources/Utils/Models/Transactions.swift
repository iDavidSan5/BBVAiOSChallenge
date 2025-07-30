//
//  Transactions.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//

import Foundation

public struct Transaction: Decodable {
    public let record: Record
    public let metadata: Metadata
    
    public init(record: Record, metadata: Metadata) {
        self.record = record
        self.metadata = metadata
    }
}

