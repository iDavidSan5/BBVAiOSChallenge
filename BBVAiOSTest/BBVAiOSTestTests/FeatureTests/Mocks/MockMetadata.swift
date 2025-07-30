//
//  MockMetadata.swift
//  Feature
//
//  Created by david.santiago on 30/07/25.
//
import Utils

struct MockMetadata {
    @MainActor static let dummyTransaction = Transaction(
        record: Record(
            balance: 1500.0,
            transactions: [
                TransactionDetail(
                    id: 1,
                    name: "Compra supermercado",
                    amount: 120.5,
                    date: "2025-07-28",
                    type: .egreso
                ),
                TransactionDetail(
                    id: 2,
                    name: "Pago salario",
                    amount: 2000.0,
                    date: "2025-07-25",
                    type: .ingreso
                )
            ]
        ),
        metadata: Metadata(
            id: "meta_001",
            isPrivate: false,
            createdAt: "2025-07-01",
            name: "Transacciones Julio"
        )
    )
}
