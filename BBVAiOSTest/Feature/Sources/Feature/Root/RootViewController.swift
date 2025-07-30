//
//  RootViewController.swift
//  Feature
//
//  Created by david.santiago on 29/07/25.
//

import UIKit
import UIModule
import ServiceModule
import CoreText

@available(iOS 13.0, *)
public final class RootViewController: UIViewController {

    let serviceModule: NetworkServiceProtocol = ServiceModule()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showDashboard()
    }

    private func showDashboard() {
        let viewModel = DashboardViewModel(service: self.serviceModule)
        let dashboardVC = DashboardViewController(viewModel: viewModel)
        addChild(dashboardVC)
        view.addSubview(dashboardVC.view)
        dashboardVC.view.frame = view.bounds
        dashboardVC.didMove(toParent: self)
    }
}

