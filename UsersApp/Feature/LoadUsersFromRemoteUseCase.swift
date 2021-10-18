//
//  LoadUsersFromRemoteUseCase.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 18/10/21.
//

import Foundation

final class LoadUsersFromRemoteUseCase: LoadUsersUseCase {
	private let usersRemoteDataSource: UsersRemoteDataSource

	init(usersRemoteDataSource: UsersRemoteDataSource) {
		self.usersRemoteDataSource = usersRemoteDataSource
	}

	func execute(completion: @escaping (Result<[User], Error>) -> Void) {
		usersRemoteDataSource.getUsers { result in
			switch result {
			case .success(let users):
				completion(.success(users))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
