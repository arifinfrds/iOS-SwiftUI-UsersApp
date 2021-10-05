//
//  UsersRemoteDataSource.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import Foundation
import Combine

protocol UsersRemoteDataSource {
	func getUsers() -> AnyPublisher<[User], Error>
}

final class URLSessionUsersRemoteDataSource: UsersRemoteDataSource {

	private let session: URLSession

	init(session: URLSession = URLSession(configuration: .ephemeral)) {
		self.session = session
	}

	func getUsers() -> AnyPublisher<[User], Error> {
		let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
		return session
			.dataTaskPublisher(for: url)
			.tryMap { (data: Data, response: URLResponse) in

				guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
					throw URLError(.badServerResponse)
				}
				return data
			}
			.decode(type: [User].self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
