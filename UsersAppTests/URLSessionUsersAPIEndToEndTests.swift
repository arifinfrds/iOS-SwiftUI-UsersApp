//
//  URLSessionUsersAPIEndToEndTests.swift
//  UsersAppTests
//
//  Created by Arifin Firdaus on 05/10/21.
//

import XCTest
import Combine
@testable import UsersApp

class URLSessionUsersAPIEndToEndTests: XCTestCase {

	func test_getUsersAPIEndToEndTests_deliversUsers() {
		let sut = makeSUT()

		_ = sut.getUsers().sink { error in
			XCTFail("Expect receive value, got error: \(error) instead.")
		} receiveValue: { users in
			XCTAssertTrue(!users.isEmpty)
		}
	}

	// MARK: - Helpers

	private func makeSUT() -> URLSessionUsersRemoteDataSource {
		let session = URLSession(configuration: .ephemeral)
		let sut = URLSessionUsersRemoteDataSource(session: session)
		return sut
	}

}
