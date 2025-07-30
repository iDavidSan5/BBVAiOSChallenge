import XCTest
import Combine
import Utils
@testable import Feature

final class DashboardViewModelTests: XCTestCase {

    private var viewModel: DashboardViewModel!
    private var mockService: MockNetworkService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = DashboardViewModel(service: mockService)
    }

    @MainActor
    func testFetchTransactions_Success() {
        let expectedTransaction: Transaction = MockMetadata.dummyTransaction
        mockService.mockTransaction = expectedTransaction
        let expectation = XCTestExpectation(description: "Transaction should be set")

        viewModel.$transaction
            .dropFirst()
            .sink { transaction in
                XCTAssertEqual(transaction?.record.balance, expectedTransaction.record.balance)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchTransactions()

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchTransactions_Failure() {
        mockService.mockTransaction = nil
        let expectation = XCTestExpectation(description: "Transaction should be nil")

        viewModel.$transaction
            .dropFirst()
            .sink { transaction in
                XCTAssertNil(transaction)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchTransactions()

        wait(for: [expectation], timeout: 1.0)
    }
}
