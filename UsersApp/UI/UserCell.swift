//
//  UserCell.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import SwiftUI

struct UserCell: View {
	let name: String
	let email: String

    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			Text(name)
				.font(.body)
				.foregroundColor(.primary)
			Text(email)
				.font(.callout)
				.foregroundColor(.secondary)
		}
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
		UserCell(name: "Arifin Firdaus", email: "sample@email.com")
    }
}
