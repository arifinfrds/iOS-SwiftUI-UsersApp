//
//  LoadUsersFromRemoteUseCaseTests.swift
//  UsersAppTests
//
//  Created by Arifin Firdaus on 18/10/21.
//

import XCTest
@testable import UsersApp

class LoadUsersFromRemoteUseCaseTests: XCTestCase {

	func test_execute_deliversUsersOnSuccess() {
		let expectedUsers = anyUsers()
		let sut = makeSUT(result: .success(expectedUsers))
		let exp = expectation(description: "wait for completion")

		var receivedUsers = [User]()
		sut.execute { result in
			switch result {
			case .success(let users):
				receivedUsers = users
			case .failure(let error):
				XCTFail("expect success, got failure \(error)")
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 0.1)

		XCTAssertEqual(expectedUsers, receivedUsers)
	}

	func test_execute_canDeliversError() {
		let sut = makeSUT(result: .failure(anyError()))
		let exp = expectation(description: "wait for completion")

		var receivedErrors = [Error]()
		sut.execute { result in
			switch result {
			case .success(let users):
				XCTFail("expect error, got success \(users)")
			case .failure(let error):
				receivedErrors.append(error)
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 0.1)

		XCTAssertTrue(!receivedErrors.isEmpty)
	}

	// MARK: - Helpers

	private func makeSUT(result: Result<[User], Error>) -> LoadUsersFromRemoteUseCase {
		let usersRemoteDataSoureStub = UsersRemoteDataSourceStub(result: result)
		let sut = LoadUsersFromRemoteUseCase(usersRemoteDataSource: usersRemoteDataSoureStub)
		return sut
	}

	private func anyUsers() -> [User] {
		return [ User(name: "any user name", email: "anyemail@mail.com") ]
	}

	private func anyError() -> Error {
		return NSError(domain: "error", code: 1)
	}

	private class UsersRemoteDataSourceStub: UsersRemoteDataSource {

		private let result: Result<[User], Error>

		internal init(result: Result<[User], Error>) {
			self.result = result
		}

		func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
			completion(result)
		}
	}

}
