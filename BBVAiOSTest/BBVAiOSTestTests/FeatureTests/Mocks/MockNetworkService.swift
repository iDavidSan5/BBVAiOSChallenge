//
//  MockNetworkService.swift
//  Feature
//
//  Created by david.santiago on 30/07/25.
//
import Foundation
import ServiceModule
import Utils

class MockNetworkService: NetworkServiceProtocol {
    var mockTransaction: Transaction?

    func loadJSON<T>(filename: String, as type: T.Type) -> T? where T : Decodable {
        return mockTransaction as? T
    }
}
