//
//  UsersView.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import SwiftUI

struct UsersView: View {
	var body: some View {
		NavigationView {
			List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
				UserCell(name: "Arifin Firdaus", email: "test@email.com")
			}
			.navigationBarTitle(Text("Users"), displayMode: .large)
		}
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
