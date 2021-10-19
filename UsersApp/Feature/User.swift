//
//  User.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import Foundation

struct User: Codable, Identifiable {
	let name: String
	let email: String
	
	var id: Int {
		return Int.random(in: 1...1000)
	}
}
