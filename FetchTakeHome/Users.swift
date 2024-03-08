//
//  User.swift
//  FetchTakeHome
//
//  Created by Noah Giboney on 3/7/24.
//

import Foundation

// data type for the response
struct User: Identifiable, Codable, Comparable{
    
    var id: Int
    var listId: Int
    var name: String?
    
    // sort by listId then sort by name
    static func <(lhs: User, rhs: User) -> Bool {
	if lhs.listId == rhs.listId {
	    return lhs.id < rhs.id
	}
	else {
	    return lhs.listId < rhs.listId
	}
    }
}

