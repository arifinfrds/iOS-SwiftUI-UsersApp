//
//  LoadUsersUseCase.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import Foundation

protocol LoadUsersUseCase {
	func execute(completion: @escaping (Result<[User], Error>) -> Void)
}

class LoadUsersFromRemoteUseCase: LoadUsersUseCase {

	private let usersRemoteDataSource: UsersRemoteDataSource

	init(usersRemoteDataSource: UsersRemoteDataSource) {
		self.usersRemoteDataSource = usersRemoteDataSource
	}

	func execute(completion: @escaping (Result<[User], Error>) -> Void) {
		usersRemoteDataSource.getUsers(completion: completion)
	}
}
