//
//  EdgeInsetExtensions.swift
//  Utils
//
//  Created by david.santiago on 30/07/25.
//
import UIKit

public extension UIEdgeInsets {
    static func edge(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
