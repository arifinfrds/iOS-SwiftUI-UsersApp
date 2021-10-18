//
//  LoadUsersFromRemoteUseCaseTests.swift
//  UsersAppTests
//
//  Created by Arifin Firdaus on 18/10/21.
//

import XCTest
@testable import UsersApp

final class LoadUsersFromRemoteUseCase {

	init(usersRemoteDataSource: UsersRemoteDataSource) {

	}

}

class LoadUsersFromRemoteUseCaseTests: XCTestCase {

	func test_init() {
		let usersRemoteDataSoureStub = UsersRemoteDataSoureStub(result: Result.success(anyUsers()))
		let sut = LoadUsersFromRemoteUseCase(usersRemoteDataSource: usersRemoteDataSoureStub)
	}

	// MARK: - Helpers

	private func anyUsers() -> [User] {
		return [ User(name: "any user name", email: "anyemail@mail.com") ]
	}


	private class UsersRemoteDataSoureStub: UsersRemoteDataSource {

		private let result: Result<[User], Error>

		internal init(result: Result<[User], Error>) {
			self.result = result
		}

		func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {

		}
	}

}
