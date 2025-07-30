//
//  TransactionCell.swift
//  UIModule
//
//  Created by david.santiago on 29/07/25.
//
import Foundation
import UIKit
import Utils

public final class TransactionDetailCell: UITableViewCell, ReusableView {
    
    private var metadata: TransactionDetail?
    
    private lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.systemBold.font(size: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.systemLight.font(size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.systemBold.font(size: 16)
        return label
    }()
    
    private let bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addObervers()
        setupConstraints()
    }
    
    public func updateMetadata(metadata: TransactionDetail, showAmount: Bool) {
        self.metadata = metadata
        nameLabel.text = metadata.name
        dateLabel.text = metadata.date.toFormattedDate()
        updateAmountLabel(showAmount: showAmount)
    }
    
    private func addObervers() {
        NotificationCenter.default.addObserver(self,
                selector: #selector(updateAmountVisibility(_:)),
                name: .didToggleShowAmount, object: nil)
    }
    
    @objc private func updateAmountVisibility(_ notification: Notification) {
        guard let showAmount = notification.object as? Bool else { return }
        updateAmountLabel(showAmount: showAmount)
    }

    private func updateAmountLabel(showAmount: Bool) {
        guard let metadata else { return }
        amountLabel.text = showAmount ? "****" : "COP \(metadata.amount > 0 ? "$" : "-$")\(abs(metadata.amount))"
        amountLabel.textColor = showAmount ? .bbvaBlue : (metadata.type == .ingreso ? .cGreen : .cRed)
    }
    
    private func addSubviews() {
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(amountLabel)
        addSubview(bottomSeparator)
    }
    
    private func setupConstraints() {
        dateLabel.anchor(
            top: topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .edge(top: 18, left: 18, bottom: 0, right: 0)
        )

        nameLabel.anchor(
            top: dateLabel.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .edge(top: 4, left: 18, bottom: 0, right: 0)
        )
        
        amountLabel.anchor(
            top: nameLabel.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .edge(top: 4, left: 0, bottom: 0, right: 18)
        )
        
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 2.0 / UIScreen.main.scale)
        ])
    }
}
