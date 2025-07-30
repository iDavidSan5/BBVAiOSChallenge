//
//  AppFonts.swift
//  UIModule
//
//  Created by david.santiago on 29/07/25.
//
import UIKit

enum AppFont {
    case systemRegular
    case systemBold
    case systemLight

    func font(size: CGFloat) -> UIFont {
        switch self {
        case .systemRegular:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case .systemBold:
            return UIFont.systemFont(ofSize: size, weight: .bold)
        case .systemLight:
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
    }
}
