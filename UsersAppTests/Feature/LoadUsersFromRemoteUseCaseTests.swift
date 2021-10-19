//
//  LoadUsersFromRemoteUseCaseTests.swift
//  UsersAppTests
//
//  Created by Arifin Firdaus on 19/10/21.
//

import XCTest
@testable import UsersApp


class LoadUsersFromRemoteUseCaseTests: XCTestCase {

	func test_execute_canDeliversUsers() {
		let sut = makeSUT(result: .success(anyUsers()))
		let exp = expectation(description: "Wait for completion")
		var receivedUsers = [User]()

		sut.execute { result in
			switch result {
			case .success(let users):
				receivedUsers = users
			case .failure(let error):
				XCTFail("expect sucess, got failure: \(error)")
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 0.1)

		XCTAssertTrue(!receivedUsers.isEmpty)
	}

	func test_execute_canDeliversError() {
		let sut = makeSUT(result: .failure(anyError()))
		let exp = expectation(description: "Wait for completion")
		var receivedErrors = [Error]()

		sut.execute { result in
			switch result {
			case .success(let users):
				XCTFail("expect fail, got data: \(users)")
			case .failure(let error):
				receivedErrors.append(error)
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 0.1)

		XCTAssertTrue(!receivedErrors.isEmpty)
		XCTAssertEqual(receivedErrors.count, 1)
	}

	func test_execute_canPerfromAnalticsWhenSuccessWithUsers() {
		let dataSourceSpy = UsersRemoteDataSourceSpy()
		let sut = LoadUsersFromRemoteUseCase(usersRemoteDataSource: dataSourceSpy)

		sut.execute { _ in }

		XCTAssertEqual(dataSourceSpy.messages, [ .getUsers ])
	}

	// MARK: - Helpers

	private func makeSUT(result: Result<[User], Error>) -> LoadUsersFromRemoteUseCase {
		let usersRemoteDataSource = UsersRemoteDataSourceStub(result: result)
		let sut = LoadUsersFromRemoteUseCase(usersRemoteDataSource: usersRemoteDataSource)
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

		init(result: Result<[User], Error>) {
			self.result = result
		}

		func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
			completion(result)
		}

	}

	private class UsersRemoteDataSourceSpy: UsersRemoteDataSource {
		private(set) var messages = [Message]()

		enum Message {
			case getUsers
		}

		func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
			messages.append(.getUsers)
		}
	}

}
