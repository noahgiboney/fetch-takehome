//
//  ListViewModel.swift
//  FetchTakeHome
//
//  Created by Noah Giboney on 3/7/24.
//

import SwiftUI
import Observation

extension ListView {
    
    enum Errors: Error {
	case url, response, data
    }
    
    @Observable
    class ViewModel {
	
	// string to search for in the list
	var searchTerm = ""
	
	// stores users from endpoint
	var users: [User] = []
	
	// returns a list of users based on search term and sorts them
	var sortedUsers: [User] {
	    
	    if searchTerm == "" {
		return users.sorted()
	    }
	    else {
		return users.filter { user in
		    user.name!.localizedCaseInsensitiveContains(searchTerm)
		}.sorted()
	    }
	}
	
	// fetch users from the url, and assign to the local users property
	func fetchUsers() async throws{
	    
	    // establish endpoint to fetch users from
	    let url = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
	    
	    guard let endpoint = URL(string: url) else {
		throw Errors.url
	    }
	    
	    // url sessions return data and response
	    let (data, response) = try await URLSession.shared.data(from: endpoint)
	    
	    // check response
	    guard let reponse  = response as? HTTPURLResponse, reponse.statusCode == 200 else {
		throw Errors.response
	    }
	    
	    do {
		// decode the data retured from request
		let decoder = JSONDecoder()
		let decodedData = try decoder.decode([User].self, from: data)
		
		// filter out nil & blank names
		users = decodedData.filter {
		    ($0.name != nil) && ($0.name != "")
		}
		
	    } catch {
		// invalid data
		throw Errors.data
	    }
	}
    }
}

