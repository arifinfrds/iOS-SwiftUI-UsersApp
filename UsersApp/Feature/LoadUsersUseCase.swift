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
