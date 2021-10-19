//
//  UsersView.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import SwiftUI

struct UsersView: View {

	@State private var users = [User]()

	var body: some View {
		NavigationView {
			List(users) { item in
				UserCell(name: item.name, email: item.email)
			}
			.navigationBarTitle(Text("Users"), displayMode: .large)
		}
		.onAppear(perform: loadUsersFromRemote)
    }

	private func loadUsersFromRemote() {
		let remoteDataSource = URLSessionUsersRemoteDataSource()
		let loadUsersFromRemote = LoadUsersFromRemoteUseCase(usersRemoteDataSource: remoteDataSource)
		loadUsersFromRemote.execute { result in
			switch result {
			case .success(let users):
				self.users = users
			case .failure:
				break
			}
		}
	}
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
