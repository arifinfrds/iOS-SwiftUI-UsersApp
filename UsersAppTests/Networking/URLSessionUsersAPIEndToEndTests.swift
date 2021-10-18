//
//  URLSessionUsersAPIEndToEndTests.swift
//  UsersAppTests
//
//  Created by Arifin Firdaus on 05/10/21.
//

import XCTest
@testable import UsersApp

class URLSessionUsersAPIEndToEndTests: XCTestCase {

	func test_getUsersAPIEndToEndTests_deliversUsers() {
		let sut = makeSUT()

		sut.getUsers { result in
			switch result {
			case let .success(users):
				XCTAssertTrue(!users.isEmpty)
			case let .failure(error):
				XCTFail("Expect receive value, got error: \(error) instead.")
			}
		}
	}

	// MARK: - Helpers

	private func makeSUT() -> URLSessionUsersRemoteDataSource {
		let session = URLSession(configuration: .ephemeral)
		let sut = URLSessionUsersRemoteDataSource(session: session)
		return sut
	}

}
