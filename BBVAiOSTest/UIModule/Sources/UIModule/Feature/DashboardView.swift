//
//  DashboardViewController.swift
//  UIModule
//
//  Created by david.santiago on 29/07/25.
//

import Foundation
import UIKit
import Utils
import Combine

public protocol DashboardViewModelProtocol {
    func fetchTransactions()
}

public protocol DashboardViewProtocol: AnyObject, UIView {
    var tableView: UITableView { get set }
    var transactions: [TransactionDetail] { get set }
    var hideAmountSwitch: UISwitch { get set }
    
    func updateMetadata(metadata: Transaction?)
    func updateAmountVisibility(hide: Bool)
}

public final class DashboardView: UIView, DashboardViewProtocol {
    
    public var transactions: [TransactionDetail] = []
    private var income: CGFloat = 0
    private var expense: CGFloat = 0
    
    private lazy var subtitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Texts.Home.accounts
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = AppFont.systemLight.font(size: 12)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Texts.Home.accountsSaving
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = AppFont.systemBold.font(size: 24)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var totalBalance: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .right
        label.text = Texts.Home.zero
        label.numberOfLines = 0
        label.font = AppFont.systemBold.font(size: 36)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var totalBalanceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .right
        label.text = Texts.Home.balance
        label.numberOfLines = 0
        label.font = AppFont.systemLight.font(size: 10)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var totalIncome: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .right
        label.text = Texts.Home.zero
        label.numberOfLines = 0
        label.font = AppFont.systemBold.font(size: 18)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var totalIncomeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .right
        label.text = Texts.Home.totalIncome
        label.numberOfLines = 0
        label.font = AppFont.systemLight.font(size: 10)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var totalExpenses: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .right
        label.text = Texts.Home.zero
        label.numberOfLines = 0
        label.font = AppFont.systemBold.font(size: 18)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var totalExpensesLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .right
        label.text = Texts.Home.totalExpenses
        label.numberOfLines = 0
        label.font = AppFont.systemLight.font(size: 10)
        label.textColor = .bbvaBlue
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.text = Texts.Home.noTransactions
        label.numberOfLines = 0
        label.font = AppFont.systemRegular.font(size: 18)
        label.textColor = .cGray
        return label
    }()
    
    public var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(TransactionDetailCell.self)
        return tableView
    }()
    
    public var hideAmountSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.isOn = UserDefaultsManager.shared.hideAmounts
        switchView.onTintColor = .systemGreen
        return switchView
    }()
    
    private var viewModel: DashboardViewModelProtocol?

    public func configure(with viewModel: DashboardViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func updateMetadata(metadata: Transaction?) {
        guard let metadata else {
            showError(hasTransactions: false)
            return
        }
        updateTransactionTable(with: metadata.record.transactions)
        udpateTotalBalance(with: metadata.record.balance)
        showError(hasTransactions: true)
    }
    
    func showError(hasTransactions: Bool) {
        tableView.isHidden = !hasTransactions
        errorLabel.isHidden = hasTransactions
    }
    
    private func updateTransactionTable(with transactions: [TransactionDetail]) {
        self.transactions = transactions
        tableView.reloadData()
    }
    
    private func udpateTotalBalance(with balance: CGFloat) {
        totalBalance.text = "$ \(balance)"
        updateIncomes()
        updateExpenses()
        updateIncomeAndExpensesLabels()
    }
    
    public func updateAmountVisibility(hide: Bool) {
        hideAmountSwitch.isOn = hide
        updateIncomeAndExpensesLabels()
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        NotificationCenter.default.post(name: .didToggleShowAmount, object: sender.isOn)
    }

    private func updateIncomes() {
        income = transactions
            .filter { $0.type == .ingreso }
                .map { $0.amount }
                .reduce(0, +)
    }
    
    private func updateExpenses() {
        expense = transactions
            .filter { $0.type == .egreso }
                .map { $0.amount }
                .reduce(0, +)
    }
    
    private func updateIncomeAndExpensesLabels() {
        totalIncome.text = "$ \(income)"
        totalExpenses.text = "$ \(abs(expense))"
    }
}

extension DashboardView {
    
    public func setup() {
        addListeners()
        addSubviews()
        setupConstraints()
        setupDelegates()
    }
    
    private func addListeners() {
        hideAmountSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    public func addSubviews() {
        addSubview(subtitleLabel)
        addSubview(titleLabel)
        addSubview(hideAmountSwitch)
        addSubview(totalBalance)
        addSubview(totalBalanceLabel)

        addSubview(totalIncome)
        addSubview(totalIncomeLabel)
        addSubview(totalExpenses)
        addSubview(totalExpensesLabel)
        
        addSubview(tableView)
        addSubview(errorLabel)
    }
    
    public func setupConstraints() {
        titleLabel.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .edge(top: 20, left: 16, bottom: 0, right: 0)
        )

        subtitleLabel.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .edge(top: 8, left: 18, bottom: 0, right: 0)
        )

        hideAmountSwitch.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 8, left: 0, bottom: 0, right: 18)
        )
        
        totalBalanceLabel.anchor(
            top: titleLabel.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 16, left: 0, bottom: 0, right: 18)
        )

        totalBalance.anchor(
            top: totalBalanceLabel.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 2, left: 0, bottom: 0, right: 18)
        )

        totalIncomeLabel.anchor(
            top: totalBalance.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 16, left: 0, bottom: 0, right: 18)
        )

        totalIncome.anchor(
            top: totalIncomeLabel.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 2, left: 0, bottom: 0, right: 18)
        )

        totalExpensesLabel.anchor(
            top: totalBalance.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .edge(top: 16, left: 16, bottom: 0, right: 0)
        )

        totalExpenses.anchor(
            top: totalExpensesLabel.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .edge(top: 2, left: 18, bottom: 0, right: 0)
        )

        tableView.anchor(
            top: totalExpenses.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 30, left: 0, bottom: 0, right: 0)
        )

        errorLabel.anchor(
            top: totalExpenses.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 30, left: 0, bottom: 0, right: 0)
        )
    }
}
