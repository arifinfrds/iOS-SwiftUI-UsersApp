//
//  ContentView.swift
//  UsersApp
//
//  Created by Arifin Firdaus on 05/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack(alignment: .leading) {
			Text("Name")
				.font(.title3)
				.foregroundColor(.primary)
			Text("Email")
				.font(.body)
				.foregroundColor(.secondary)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
