//
//  UsersRemoteDataSource.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import Foundation

protocol UsersRemoteDataSource {
	func getUsers(completion: @escaping (Result<[User], Swift.Error>) -> Void)
}

final class URLSessionUsersRemoteDataSource: UsersRemoteDataSource {

	private let session: URLSession

	enum Error: Swift.Error {
		case unexpectedResponse
		case decodingFail
	}

	init(session: URLSession = URLSession(configuration: .ephemeral)) {
		self.session = session
	}

	func getUsers(completion: @escaping (Result<[User], Swift.Error>) -> Void) {
		let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

		session.dataTask(with: url) { data, urlResponse, error in
			if let dataTaskError = error {
				completion(.failure(dataTaskError))
			} else {
				guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200, let receivedData = data else {
					completion(.failure(URLSessionUsersRemoteDataSource.Error.unexpectedResponse))
					return
				}

				do {
					let users = try JSONDecoder().decode([User].self, from: receivedData)
					completion(.success(users))
				} catch {
					completion(.failure(URLSessionUsersRemoteDataSource.Error.decodingFail))
				}
			}
		}
		.resume()
	}

}
