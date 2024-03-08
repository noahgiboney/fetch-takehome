//
//  ListView.swift
//  FetchTakeHome
//
//  Created by Noah Giboney on 3/7/24.
//

import SwiftUI

struct ListView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack{
	    
	    // list out sorted users
	    List(viewModel.sortedUsers){ user in
		
		// display simple user info
		HStack{
		    VStack(alignment: .leading, spacing: 5){
			Text("Name: ").bold() + Text(user.name ?? "")
			Text("listId: ").bold() + Text("\(user.listId)")
		    }
		    
		    Spacer()
		    
		    Image(systemName: "person")
		}
	    }
	    .navigationTitle("User List")
	    .searchable(text: $viewModel.searchTerm, prompt: "Search by name")
	    .task {
		do {
		    
		    // fetch users from endpoint
		    try await viewModel.fetchUsers()
		    
		// handle errors with print statement
		} catch Errors.url {
		    print("invalid url endpoint")
		} catch Errors.data{
		    print("error downloading")
		} catch Errors.response {
		    print("invalid http response")
		}
		catch {
		    print("other error")
		}
	    }
	}
    }
}

#Preview {
    ListView()
}
