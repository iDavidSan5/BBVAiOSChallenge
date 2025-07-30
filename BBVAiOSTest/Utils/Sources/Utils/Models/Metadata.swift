//
//  Metadata.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//
import Foundation

public struct Metadata: Codable {
    public let id: String
    public let isPrivate: Bool
    public let createdAt: String
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case id
        case isPrivate = "private"
        case createdAt
        case name
    }
    
    public init(id: String, isPrivate: Bool, createdAt: String, name: String) {
        self.id = id
        self.isPrivate = isPrivate
        self.createdAt = createdAt
        self.name = name
    }
}
