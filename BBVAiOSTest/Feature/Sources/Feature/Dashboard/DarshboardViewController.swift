//
//  DarshboardViewController.swift
//  Feature
//
//  Created by david.santiago on 29/07/25.
//
import Foundation
import UIKit
import UIModule
import Utils
import Combine

@available(iOS 13.0, *)
public final class DashboardViewController: UIViewController {

    private let viewModel: DashboardViewModelProtocol
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    public var dashboardView: DashboardViewProtocol = DashboardView()

    public init(viewModel: DashboardViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDashboardView()
        bindViewModel()
        setupHideAmountSwitch()
        viewModel.fetchTransactions()
    }
    
    public func bindViewModel() {
        guard let vm = viewModel as? DashboardViewModel else { return }
        vm.$transaction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transaction in
                self?.dashboardView.updateMetadata(metadata: transaction)
            }
            .store(in: &cancellables)
    }
    
    public func setupHideAmountSwitch() {
        dashboardView.hideAmountSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
    }
    
    @objc private func switchToggled(_ sender: UISwitch) {
        UserDefaultsManager.shared.hideAmounts = !UserDefaultsManager.shared.hideAmounts
        dashboardView.updateAmountVisibility(hide: UserDefaultsManager.shared.hideAmounts)
    }

    private func setupDashboardView() {
        view.addSubview(dashboardView)
        dashboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dashboardView.topAnchor.constraint(equalTo: view.topAnchor),
            dashboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dashboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dashboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
