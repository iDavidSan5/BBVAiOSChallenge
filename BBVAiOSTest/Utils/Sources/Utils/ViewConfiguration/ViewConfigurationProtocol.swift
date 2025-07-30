//
//  ViewConfigurationProtocol.swift
//  Utils
//
//  Created by david.santiago on 29/07/25.
//

import Foundation

public protocol ViewConfiguration {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewConfiguration {
    public func setup() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
    
    public func setupStyle() { }
}
