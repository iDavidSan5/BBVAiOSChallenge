//
//  NetworkServiceProtocol.swift
//  ServiceModule
//
//  Created by david.santiago on 29/07/25.
//

import Foundation
import Alamofire

public protocol NetworkServiceProtocol {
    func loadJSON<T: Decodable>(filename: String, as type: T.Type) -> T?
}
